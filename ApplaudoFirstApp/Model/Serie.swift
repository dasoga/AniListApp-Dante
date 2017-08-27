//
//  Serie.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/25/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import Foundation

class Serie: NSObject {
    var id: Int?
    var title_english: String?
    var image_url_med: String?
    var image_url_lge: String?
    var sdescription: String?
    var series_type: String?
    var average_score: Int?
    var mean_score: Int?
    var popularity: Int?
    var genres: [String]?
    var totalEpisodes: Int?
    var duration: Int?
    
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
