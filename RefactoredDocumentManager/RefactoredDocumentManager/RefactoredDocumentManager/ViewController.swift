//
//  ViewController.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/4/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, tableViewCellDelegate {
    
    
    
    func sendFolder(pictureFolder: pictureFolderModel, indexPath: IndexPath) {
        downloadandUnzip(folderPath: URL(string: pictureFolder.zippedImagesUrl)!) {
            let selectedCell = self.picturesTableView.cellForRow(at: indexPath) as! PictureTableViewCell
            let unzippedImagesURL = getUnzippedImagesURL(folder: pictureFolder)
            let imageLocations = getImageURLSFromFolder(folderLocation: unzippedImagesURL)
            let filteredImageLocations = filterImageURLS(imageURLS: imageLocations)
            self.pictureFolders[indexPath.row].imagePaths = filteredImageLocations
            let fullImageLocationPath = getImageLocation(pictureLocation: filteredImageLocations[0], folder: pictureFolder)
            selectedCell.thumbnailImage.image = loadImage(imagePath: fullImageLocationPath)
            
        }
    }
    
    
    var images: [UIImage] = []
    var pictureFolders: [pictureFolderModel] = []
    
    
    
    @IBOutlet weak var picturesTableView: UITableView!
    
    
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
        cell.delegate = self as tableViewCellDelegate
        cell.pictureFolder = self.pictureFolders[indexPath.row]
        cell.indexPath = indexPath
        cell.pictureFolderName.text = self.pictureFolders[indexPath.row].collectionName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedFolder = self.pictureFolders[indexPath.row]
         self.performSegue(withIdentifier: "toDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toDetail" {
                let detailVC = segue.destination as! DetailViewController
                let indexPath = self.picturesTableView.indexPathForSelectedRow
                detailVC.folder = self.pictureFolders[(indexPath?.row)!]

            }
        }
    }
    
    
    
}


