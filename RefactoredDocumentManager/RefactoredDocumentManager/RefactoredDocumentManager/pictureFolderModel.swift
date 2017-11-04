//
//  pictureFolderModel.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/4/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation

struct pictureFolderModel: Codable {
    let collectionName: String
    let zippedImagesUrl: String
    var unzippedImagesUrl: URL?
    
    init(collectionName: String, zippedImagesUrl: String) {
        self.collectionName = collectionName
        self.zippedImagesUrl = zippedImagesUrl
        self.unzippedImagesUrl = nil
    }
    
}

extension pictureFolderModel {
    
    enum codingKeys: String, CodingKey {
        case collectionName = "collection_name"
        case zippedImagesUrl = "zipped_images_url"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: codingKeys.self)
        let collectionName = try container.decode(String.self, forKey: .collectionName)
        let zippedImagesUrl = try container.decode(String.self, forKey: .zippedImagesUrl)
        self.init(collectionName: collectionName, zippedImagesUrl: zippedImagesUrl)
        
    }
}
