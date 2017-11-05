//
//  ViewController.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/4/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var images: [UIImage] = []
    var pictureFolders: [pictureFolderModel] = []
    var selectedIndexForFolder: Int?
    var imagePathsToSend: [String]?
    
    @IBOutlet weak var picturesTableView: UITableView!
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.images = []
        if self.pictureFolders.count == 0 {
        getZippedImages()
        }
        
    }
    
    
    
    
    func getZippedImages() {
        Networking.instance.fetch { (data) in
            let pictureFolderModels = try? JSONDecoder().decode([pictureFolderModel].self, from: data)
            if let pictureFolderModels = pictureFolderModels {
                self.pictureFolders = pictureFolderModels
                DispatchQueue.main.async {
                    self.picturesTableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictureFolders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.picturesTableView.dequeueReusableCell(withIdentifier: "pictureCell") as! PictureTableViewCell
        if self.images.count != 0 {
            cell.thumbnailImage.image = self.images[indexPath.row]
        }
        cell.pictureFolderName.text = self.pictureFolders[indexPath.row].collectionName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedFolder = self.pictureFolders[indexPath.row]
        self.selectedIndexForFolder = indexPath.row

        
        self.images = []
        let downloadImageLink = URL(string: selectedFolder.zippedImagesUrl)
        if selectedFolder.imagePaths?.count == 0 {
            downloadandUnzip(folderPath: downloadImageLink!) {
            //before we get our imagePaths from the selected folder's unzipped URL, we first have to set our unzipped URL.
            let unzippedImagesURL = getUnzippedImagesURL(folder: selectedFolder)
            selectedFolder.unzippedImagesUrl = unzippedImagesURL
            let selectedFolderUnzippedURL = selectedFolder.unzippedImagesUrl
           
            let imageLocations = getImageURLSFromFolder(folderLocation: selectedFolderUnzippedURL!)
            selectedFolder.imagePaths = imageLocations
            self.imagePathsToSend = imageLocations
            let filteredImageLocations = filterImageURLS(imageURLS: imageLocations)
            for imageLocation in filteredImageLocations {
                let fullImageLocationPath = getImageLocation(pictureLocation: imageLocation, folder: selectedFolder)
                let newImage = loadImage(imagePath: fullImageLocationPath)
                self.images.append(newImage!)
                //now we have our array full of images, how can we display them
                
            }
            
            let cell = self.picturesTableView.cellForRow(at: indexPath) as! PictureTableViewCell
            cell.thumbnailImage.image = self.images[0]
            self.performSegue(withIdentifier: "toDetail", sender: self)
        }
           
           
        } else {
            var selectedFolder = self.pictureFolders[indexPath.row]
            let unzippedImagesURL = getUnzippedImagesURL(folder: selectedFolder)
            selectedFolder.unzippedImagesUrl = unzippedImagesURL
            let selectedFolderUnzippedURL = selectedFolder.unzippedImagesUrl
            let imageLocations = getImageURLSFromFolder(folderLocation: selectedFolderUnzippedURL!)
            selectedFolder.imagePaths = imageLocations
            self.imagePathsToSend = imageLocations
            let filteredImageLocations = filterImageURLS(imageURLS: imageLocations)
            for imageLocation in filteredImageLocations {
                let fullImageLocationPath = getImageLocation(pictureLocation: imageLocation, folder: selectedFolder)
                let newImage = loadImage(imagePath: fullImageLocationPath)
                self.images.append(newImage!)
            }
            let cell = self.picturesTableView.cellForRow(at: indexPath) as! PictureTableViewCell
            cell.thumbnailImage.image = self.images[0]
            self.performSegue(withIdentifier: "toDetail", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toDetail" {
                let detailVC = segue.destination as! DetailViewController
                detailVC.collageImages = self.images
                let selectedImageURLS = self.imagePathsToSend!
                detailVC.imagePaths = selectedImageURLS
                detailVC.selectedIndexForFolder = self.selectedIndexForFolder
            }
        }
    }
    
    
    
}


