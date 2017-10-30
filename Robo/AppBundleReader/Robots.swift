//
//  Robots.swift
//  AppBundleReader
//
//  Created by Sunny Ouyang on 10/27/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import Foundation

class Robot: Codable {
    
    
    let name: String
    let personality: String
    let phrase: String
    let image: String
    
    init(name: String, personality: String, phrase: String, image: String) {
        self.name = name
        self.personality = personality
        self.phrase = phrase
        self.image = image
    }
    
    
//    "name": "Xero",
//    "personality": "Cunning",
//    "image": "https://robohash.org/xero",
//    "phrase": "Please don't reload, I'll DIE!"
    
}
