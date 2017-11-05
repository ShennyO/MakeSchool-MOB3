//
//  HelperFunctions.swift
//  RefactoredDocumentManager
//
//  Created by Sunny Ouyang on 11/4/17.
//  Copyright © 2017 Sunny Ouyang. All rights reserved.
//

import Foundation
import Zip


//from the URL given, get the correct folder name
func getName(zippedImageURL: String) -> String {
    let lastURLComponent = URL(string: zippedImageURL)!
    let lastComponent = lastURLComponent.lastPathComponent
    let indexEndOfText = lastComponent.index(lastComponent.endIndex, offsetBy: -4)
    let name = lastComponent[..<indexEndOfText]
    return String(describing: name)
}

func unzipping(folderPath:URL) {
    let fm = FileManager.default
    let cachesDir = try? FileManager.default.url(for: .cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
    let destinationURL: URL = cachesDir!
    Zip.addCustomFileExtension("tmp")
    try? Zip.unzipFile(folderPath, destination:destinationURL, overwrite: true, password: "", progress: { (progress) -> () in
    })
}

func downloadandUnzip(folderPath: URL, completion: @escaping () -> ()) {
    //DOWNLOADING THE CONTENTS FROM THE ZIPPED IMAGES URL
    let dispatchGroup = DispatchGroup()
     dispatchGroup.enter()
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    let request = URLRequest(url:folderPath)
    var checker = false
    
    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
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
            if progress == 1.0 {
                
                DispatchQueue.main.async {
                     dispatchGroup.leave()
                }
               
            }
        })
        
        }
        task.resume()
    dispatchGroup.notify(queue: .main) {
          completion()
    }
    

   
    
}


//Returns to us an array of already cleaned image URLS
func getImageURLSFromFolder(folderLocation: URL) -> [String] {
    let fs = FileManager.default
    let imageURLS = try? fs.contentsOfDirectory(atPath: folderLocation.path)
    return imageURLS!
}

func getUnzippedImagesURL(folder: pictureFolderModel) -> URL {
    let zippedImageURL = folder.zippedImagesUrl
    let folderName = getName(zippedImageURL: zippedImageURL)
    let cachesDir = try? FileManager.default.url(for: .cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
    let unzippedURL = cachesDir?.appendingPathComponent(folderName)
    return unzippedURL!
}

func filterImageURLS(imageURLS: [String]) -> [String] {
    var tempArray: [String] = []
    for imageURL in imageURLS {
        if imageURL.range(of:"jpg") != nil || imageURL.range(of: "jpeg") != nil || imageURL.range(of: "png") != nil {
            tempArray.insert(imageURL, at: 0)
        }
    }
    return tempArray
}

func loadImage(imagePath: String) -> UIImage? {
    
    do {
        let imagePathUrl = URL(fileURLWithPath: imagePath)
        let imageData = try Data(contentsOf: imagePathUrl)
        return UIImage(data: imageData)
    } catch {
        print("Error loading image : \(error)")
    }
    return nil
}

func getImageLocation(pictureLocation: String, folder: pictureFolderModel) -> String {
    let cachesDir = try? FileManager.default.url(for: .cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
    let folderName = getName(zippedImageURL: folder.zippedImagesUrl)
    let imageFolderLocation = String(describing: cachesDir!) + folderName
    let imageFolderURL = URL(string: imageFolderLocation)
    let fullImageLocation = imageFolderURL?.appendingPathComponent(pictureLocation)
    return fullImageLocation!.path
    
}


    

