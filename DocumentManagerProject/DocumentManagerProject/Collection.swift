//
//  Collection.swift
//  DocumentManagerProject
//
//  Created by Sunny Ouyang on 11/1/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation

struct Collection: Codable {
    
    let collectionName: String
    let zippedImagesUrl: String
    var unzippedImagesUrl: URL?
    
    init(collectionName: String, zippedImagesUrl: String) {
        self.collectionName = collectionName
        self.zippedImagesUrl = zippedImagesUrl
        self.unzippedImagesUrl = nil
    }
    
}

extension Collection {
    
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
