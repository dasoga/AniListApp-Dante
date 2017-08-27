//
//  Request.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/26/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import Foundation

class Request: NSObject {
    static let shared = Request()
    
    func getSeriesData(completion: @escaping ([Serie]?) -> ()){
        if validToken(){
        let dataURL = "https://anilist.co/api/anime/search/original"
        var request = URLRequest(url: URL(string: dataURL)!)
        request.addValue("Bearer 6lMaxDHMRR5kaqCB3SG0V8nSnn1RuS3gzkusmsL9", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 401{
                    print("Refresh token...")
                    return
                }
            }
            
            // Get data success
            // Show collection view if everthing was success
//            self.collectionView?.isHidden = false
            
            
            // Try to parse the data response
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var series = [Serie]()
                
                for dictionary in json as! [[String: Any]] {
                    // ToDo
                    // Make this as object, not parsing manually....
                    // Parsing data manually
                    let serie = Serie()
                    serie.serieTitle = dictionary["title_english"] as? String
                    serie.serieImageURL = dictionary["image_url_med"] as? String
                    series.append(serie)
                }
                
                DispatchQueue.main.async {
                    completion(series)
                }
            }catch let jsonError{
                print(jsonError)
            }
            
            
            }.resume()
        }else{
            refreshToken()
        }
    }
    
    private func validToken()->Bool{
        if let tokenExpireTime = UserDefaults.standard.object(forKey: Constants.TOKEN_EXPIRE_TIME) as? Int{
            if tokenExpireTime > 300{
                return true
            }else{
                return false
            }
        }
        
        return false
    }
    
    private func refreshToken(){
        
    }
    
}
