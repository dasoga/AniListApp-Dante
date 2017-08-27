//
//  Request.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/26/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import Foundation
import OAuthSwift

class Request: NSObject {
    static let shared = Request()
    
    var oauthswift: OAuth2Swift?
    
    func getSeriesData(completion: @escaping ([Serie]?) -> ()){
        if let tokenExpireDate = UserDefaults.standard.object(forKey: Constants.TOKEN_EXPIRE_TIME) as? Date{            
            if tokenExpireDate < Date(){
                self.getNewToken(completion: { (newToken) in
                    guard let token = newToken else { return }
                    self.getDataFromServer(token: token, completion: { (series) in
                        completion(series)
                    })
                })
            }else{
                if let oauthToken = UserDefaults.standard.object(forKey: Constants.TOKEN_LOGIN) as? String{
                    self.getDataFromServer(token: oauthToken, completion: { (series) in
                        completion(series)
                    })
                }
            }
        }else{
            getNewToken(completion: { (newToken) in
                guard let token = newToken else { return }
                self.getDataFromServer(token: token, completion: { (series) in
                    completion(series)
                })
            })
        }
    }
    
    private func getDataFromServer(token: String, completion: @escaping ([Serie]?) -> ()){
        let dataURL = "https://anilist.co/api/anime/search/original"
        var request = URLRequest(url: URL(string: dataURL)!)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                completion(nil)
                return
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
    }
    private func getNewToken(completion: @escaping (String?) ->()){
        oauthswift = OAuth2Swift(
            consumerKey:    "dasoga-sbnuh",
            consumerSecret: "2OtAOqDmi1kL3uGJxhjGNKP31BJ",
            authorizeUrl:   "https://anilist.co/api/auth/authorize",
            accessTokenUrl: "https://anilist.co/api/auth/access_token",
            responseType:   "code"
        )
        let _ = oauthswift?.authorize(
            withCallbackURL: URL(string: "ApplaudoFirstApp://oauth-callback")!,
            scope: "", state:"AniList",
            success: { credential, response, parameters in
                debugPrint(response)
                print(credential.oauthToken)
                print(credential.oauthTokenExpiresAt)
                print(credential)
                completion(credential.oauthToken)
                // Do your request
                UserDefaults.standard.set(credential.oauthToken, forKey: Constants.TOKEN_LOGIN)
                UserDefaults.standard.set(credential.oauthTokenExpiresAt, forKey: Constants.TOKEN_EXPIRE_TIME)
                UserDefaults.standard.synchronize()
                
        },
            failure: { error in
                completion(nil)
                print(error.localizedDescription)
        }
        )
    }
    
}
