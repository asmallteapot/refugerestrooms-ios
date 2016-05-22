//
//  BasicJSONParser.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/22/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Basic JSON parser.
internal struct BasicJSONParser: JSONParser {
    
    // MARK: - Protocol conformance
    
    // MARK: JSONParser
    
    func restroomsFromJSON(json: AnyObject) -> (restrooms: [Restroom]?, error: NSError?) {
        guard let jsonArray = json as? [[String : AnyObject]] else {
            let errorDescription = "Cannot parse JSON."
            let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonparser", code: 1, userInfo: [NSLocalizedDescriptionKey : errorDescription])
            
            return (nil, error)
        }
        
        var restrooms: [Restroom] = []
        
        for json in jsonArray {
            guard let name = json["name"] as? String else {
                let errorDescription = "Cannot parse JSON."
                let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonparser", code: 1, userInfo: [NSLocalizedDescriptionKey : errorDescription])
                
                return (nil, error)
            }
            
            let restroom = Restroom(name: name)
            
            restrooms.append(restroom)
        }
        
        return (restrooms, nil)
    }
    
}
