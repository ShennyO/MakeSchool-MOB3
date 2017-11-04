//
//  Networking.swift
//  DocumentManagerProject
//
//  Created by Sunny Ouyang on 11/1/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation

class Network {
    static let instance = Network()
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
