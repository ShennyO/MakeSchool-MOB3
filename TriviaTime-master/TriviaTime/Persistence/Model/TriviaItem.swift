//
//  TriviaItem.swift
//  TriviaTime
//
//  Created by Sunny Ouyang on 12/1/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import Foundation
import RealmSwift

class TriviaItem: Object {
    @objc dynamic var question: String = ""
    @objc dynamic var answer: String = ""
    @objc dynamic var correct: Bool = false
}
