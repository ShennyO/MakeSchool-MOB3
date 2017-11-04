//
//  Networking.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/4/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation

class Networking {
    static let instance = Networking()
    let calledURL = URL(string: "https://api.myjson.com/bins/17ge17")
    let session = URLSession.shared
    func fetch(completion: @escaping (Data) -> Void) {
        var calledURLRequest = URLRequest(url: calledURL!)
        calledURLRequest.httpMethod = "GET"
        session.dataTask(with: calledURLRequest) { (data, resp, err) in
            if let data = data {
                completion(data)
            }
            }.resume()
    }
}
