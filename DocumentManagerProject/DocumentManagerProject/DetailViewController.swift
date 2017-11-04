//
//  DetailViewController.swift
//  DocumentManagerProject
//
//  Created by Sunny Ouyang on 11/1/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    
    
    var niceImages: [UIImage] = []
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.niceImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "collageImage", for: indexPath) as! ImageCollectionViewCell
        cell.collageImage.image = niceImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 110, height: 110)
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
