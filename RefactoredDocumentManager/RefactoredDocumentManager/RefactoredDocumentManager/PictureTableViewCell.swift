//
//  PictureTableViewCell.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/4/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import UIKit

protocol tableViewCellDelegate {
    func sendFolder(pictureFolder: pictureFolderModel, indexPath: IndexPath)
}

class PictureTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var pictureFolderName: UILabel!
    var pictureFolder: pictureFolderModel?
    var delegate: tableViewCellDelegate?
    var indexPath: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func downloadTapped(_ sender: Any) {
        
        self.delegate?.sendFolder(pictureFolder: self.pictureFolder!, indexPath: self.indexPath!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
