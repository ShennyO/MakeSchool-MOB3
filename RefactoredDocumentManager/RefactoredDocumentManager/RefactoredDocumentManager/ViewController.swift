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

    @IBOutlet weak var picturesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getZippedImages()
       
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


}

