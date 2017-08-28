//
//  Serie.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/25/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import Foundation

class Serie: NSObject {
    var id: NSNumber?
    var title_english: String?
    var image_url_med: String?
    var image_url_lge: String?
    var image_url_banner: String?
    var sdescription: String?
    var series_type: String?
    var average_score: NSNumber?
    var mean_score: NSNumber?
    var popularity: NSNumber?
    var genres: [String]?
    var totalEpisodes: NSNumber?
    var duration: NSNumber?
    
    override func setValue(_ value: Any?, forKey key: String) {
        let upperCaseFirstCharacter = String(key.characters.first!).uppercased()
        let range = key.startIndex..<key.index(key.startIndex, offsetBy: 1)
        let selectorString = key.replacingCharacters(in: range, with: upperCaseFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds{
            return
        }
        super.setValue(value, forKey: key)
    }
    
    init(dictionary: [String: Any]){
        super.init()
        setValuesForKeys(dictionary)
    }

}
