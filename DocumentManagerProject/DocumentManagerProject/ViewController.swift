//
//  ViewController.swift
//  DocumentManagerProject
//
//  Created by Sunny Ouyang on 11/1/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit
import Zip

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
   
    
    var picFileArray: [Collection] = []
    var imagesDict: [String: [String]] = [:]
    var cleanedImagesDict: [String: [String]] = [:]
    var imagesArray: [UIImage] = [] {
        didSet {
            self.collageTableView.reloadData()
        }
    }
    @IBOutlet weak var collageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagesArray = []
        //1 get our collections model where we get the name of the collageFile, and the location on the internet where we can download the zipped iamges
        Network.instance.fetch { (data) in
            let jsonDownloadURLS = try? JSONDecoder().decode([Collection].self, from: data)
            if let downloadURLS = jsonDownloadURLS {
                //save the collection models inside our picFileArray
                self.picFileArray = downloadURLS
                DispatchQueue.main.async {
                    self.collageTableView.reloadData()
                }
            }
        }

    }
    
    //Returns the an array of all the image Paths inside a folder
    func getImagePaths(url: String) -> [String] {
        let fs = FileManager.default
        let imageURLS = try? fs.contentsOfDirectory(atPath: url)
        return imageURLS!
    }
    
    //Downloads the contents of the URLs from the api we consumed and unzips it to the Cache Directory
    //When we click on the cell, we want to download the image file from the zipped images URL and unzip them to their specific folders
    func downloadFile(fileURL: URL, destinationURL: URL, completion: () -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
            let fm = FileManager.default
            Zip.addCustomFileExtension("tmp")
            try? Zip.unzipFile(tempLocalUrl!, destination: destinationURL, overwrite: true, password: "", progress: { (progress) -> () in
                
            })
            
        }
        task.resume()
        
        completion()
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.picFileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.collageTableView.dequeueReusableCell(withIdentifier: "collageCell") as! CollageTableViewCell
        cell.collageName.text = self.picFileArray[indexPath.row].collectionName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cachesDir = try? FileManager.default.url(for: .cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        //Our dictionary
        let selectedCollageFile = self.picFileArray[indexPath.row]
        let destinationURL:URL = cachesDir!
        let directoryName = getName(path: self.picFileArray[indexPath.row].zippedImagesUrl)
        let fullDirectory = String(describing: cachesDir!) + "\(directoryName)"
        //Then add the CollageFile Path to our cache dictionary
        
       
        
        
        self.downloadFile(fileURL: URL(string: selectedCollageFile.zippedImagesUrl)!, destinationURL: destinationURL) {
            
            self.picFileArray[indexPath.row].unzippedImagesUrl = URL(string:fullDirectory)!
            self.imagesDict[self.picFileArray[indexPath.row].collectionName] = self.getImagePaths(url: String(describing: self.picFileArray[indexPath.row].unzippedImagesUrl!.path))
            for (_, paths) in self.imagesDict {
                var tempArray: [String] = []
                for (_, path) in paths.enumerated() {
                    if path.range(of:"jpg") != nil || path.range(of: "jpeg") != nil || path.range(of: "png") != nil {
//                       tempArray.append(path)
                        tempArray.insert(path, at: 0)
                    }
                }
               self.cleanedImagesDict[self.picFileArray[indexPath.row].collectionName] = tempArray
            }
            performSegue(withIdentifier: "toDetail", sender: self)
        }
        
    }
    
    func getName(path: String) -> String {
        let lastURLComponent = URL(string: path)!
        let lastComponent = lastURLComponent.lastPathComponent
        let indexEndOfText = lastComponent.index(lastComponent.endIndex, offsetBy: -4)
        let name = lastComponent[..<indexEndOfText]
        return String(describing: name)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toDetail" {
                let cachesDir = try? FileManager.default.url(for: .cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)

                let indexPath = self.collageTableView.indexPathForSelectedRow
                let currentCell = self.collageTableView.cellForRow(at: indexPath!) as! CollageTableViewCell
               
                let selectedFile = self.picFileArray[(indexPath?.row)!].collectionName
                let images = self.cleanedImagesDict[selectedFile]!
                let directoryName = getName(path: self.picFileArray[indexPath!.row].zippedImagesUrl)
                var tempImages: [UIImage] = []
                
              
                    
               
                for image in images {
                    let fullDirectory = String(describing: cachesDir!) + "\(directoryName)"
                    let fullDirectoryURL = URL(string: fullDirectory)!
                    let newImagePath = fullDirectoryURL.appendingPathComponent(image).path
                    let newImage = self.load(imagePath: newImagePath)
                    tempImages.append(newImage!)
                    
                }
                self.imagesArray = tempImages
                
                let selectedCell = self.collageTableView.cellForRow(at: indexPath!) as! CollageTableViewCell
                selectedCell.thumbnailImage.image = self.imagesArray[0]
                let detailVC = segue.destination as! DetailViewController
                detailVC.niceImages = self.imagesArray
                
            }
        }
    }
    
    func load(imagePath: String) -> UIImage? {
    
        do {
            let imagePathUrl = URL(fileURLWithPath: imagePath)
            let imageData = try Data(contentsOf: imagePathUrl)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    

}

