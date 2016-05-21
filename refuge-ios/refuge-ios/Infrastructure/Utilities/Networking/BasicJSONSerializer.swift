//
//  BasicJSONSerializer.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/21/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Basic JSON serializer utilizing NSJSONSerialization.
internal struct BasicJSONSerializer: JSONSerializer {
    
    // MARK: - Protocol conformance
    
    // MARK: JSONSerializer
    
    func serializeDataToJSON(data: NSData?, readingOptions: NSJSONReadingOptions) -> (json: AnyObject?, error: NSError?) {
        guard let data = data else {
            let errorDescription = "JSON serialization failed with nil or zero length input data."
            let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonserializer", code: 1, userInfo: [NSLocalizedDescriptionKey : errorDescription])
            
            return (nil, error)
        }
        
        var json: AnyObject? = nil
        
        do {
            try json = NSJSONSerialization.JSONObjectWithData(data, options: readingOptions)
        } catch {
            return (nil, error as NSError)
        }
        
        guard let j = json else {
            let errorDescription = "JSON serialization failed but no error indicated."
            let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonserializer", code: 2, userInfo: [NSLocalizedDescriptionKey : errorDescription])
            
            return (nil, error)
        }
        
        return (j, nil)
    }
    
}
