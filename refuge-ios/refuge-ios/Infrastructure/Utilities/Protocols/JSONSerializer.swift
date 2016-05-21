//
//  JSONSerializer.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/21/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Serializes data to JSON.
internal protocol JSONSerializer {
    
    /**
     Serializes data to JSON.
     
     - parameter data:           Data to serialize.
     - parameter readingOptions: Reading options.
     
     - returns: JSON when successful, error otherwise.
     */
    func serializeDataToJSON(data: NSData?, readingOptions: NSJSONReadingOptions) -> (json: AnyObject?, error: NSError?)
    
}
