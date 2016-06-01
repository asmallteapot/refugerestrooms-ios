//
//  HTTPResponse.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/24/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// HTTP response.
internal struct HTTPResponse {
    
    // MARK: - Types
    
    /// HTTP status code.
    enum StatusCode: Int {
        
        /// OK (200).
        case OK = 200
        
        /// No content (204).
        case NoContent = 204
        
    }
    
    // MARK: - Properties
    
    /// Data.
    let data: NSData?
    
    /// Status code.
    let statusCode: StatusCode
    
}
