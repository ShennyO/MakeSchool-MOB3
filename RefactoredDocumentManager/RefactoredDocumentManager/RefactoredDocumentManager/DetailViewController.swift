//
//  DetailViewController.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/5/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var collageImages: [UIImage] = []
    var imagePaths: [String] = []
    var selectedIndexForFolder: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collageImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionCell", for: indexPath) as! ImageCollectionViewCell
        cell.folderImage.image = self.collageImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 100.0, height: 100.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "return" {
                let VC1 = segue.destination as! ViewController
                VC1.pictureFolders[selectedIndexForFolder!].imagePaths = self.imagePaths
            }
        }
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "return", sender: self)
    }
}
    



