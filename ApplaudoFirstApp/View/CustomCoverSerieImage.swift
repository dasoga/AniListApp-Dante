//
//  CustomCoverSerieImage.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/26/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//
/*
 
 This class helps to download images from URL and save them in cache
 
 
*/
import UIKit

class CustomCoverSerieImage: UIImageView {
    
    var imageUrlString: String?
    
    var imageCache = NSCache<AnyObject, AnyObject>()

    func loadImageFromURL(urlString: String){
        // Function to download the image with a url string
        //
        imageUrlString = urlString
        
        // Download image
        
        // Clear cache to avoid duplicate or wrong position
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (imageData, response, error) in
            // Check if data has an error
            if error != nil{
                print(error)
                return
            }
            
            // Success
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: imageData!)
                self.imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                
                self.image = imageToCache
            }
        }).resume()
        
    }

}
