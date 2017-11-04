//
//  HelperFunctions.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/4/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation
import Zip

class HelperFunctions {
    //from the URL given, get the correct folder name 
    func getName(path: String) -> String {
        let lastURLComponent = URL(string: path)!
        let lastComponent = lastURLComponent.lastPathComponent
        let indexEndOfText = lastComponent.index(lastComponent.endIndex, offsetBy: -4)
        let name = lastComponent[..<indexEndOfText]
        return String(describing: name)
    }
    
    func downloadandUnzip(folderPath: URL) {
        //DOWNLOADING THE CONTENTS FROM THE ZIPPED IMAGES URL
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:folderPath)
        
        _ = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let _ = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
            } else {
                print("Error took place while downloading a file")
            }
             //UNZIPPING
            
            let fm = FileManager.default
            let cachesDir = try? FileManager.default.url(for: .cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let destinationURL: URL = cachesDir!
            Zip.addCustomFileExtension("tmp")
            try? Zip.unzipFile(tempLocalUrl!, destination:destinationURL, overwrite: true, password: "", progress: { (progress) -> () in
            })
        }
        
        
       
        
        
        
    }
    
}
