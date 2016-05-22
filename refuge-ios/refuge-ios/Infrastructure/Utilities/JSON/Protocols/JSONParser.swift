//
//  JSONParser.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/22/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Parses JSON into objects.
internal protocol JSONParser {
    
    /**
     Parses restrooms from provided JSON.
     
     - parameter json: JSON.
     
     - returns: Result with restrooms when successful, error otherwise.
     */
    func restroomsFromJSON(json: AnyObject) -> (restrooms: [Restroom]?, error: NSError?)
    
}
