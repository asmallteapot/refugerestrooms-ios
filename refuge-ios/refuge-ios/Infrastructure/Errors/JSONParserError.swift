//
//  JSONParserError.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/22/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// JSON parser error.
enum JSONParserError: ErrorType {
    
    /// Invalid value found while parsing.
    case InvalidValue
    
    /// JSON is not in expected format.
    case UnexpectedFormat
    
}

// MARK: - Protocol conformance

// MARK: CustomErrorConvertible

extension JSONParserError: CustomErrorConvertible {
    
    var code: Int {
        switch self {
        case .InvalidValue:
            return 1
        case .UnexpectedFormat:
            return 2
        }
    }
    
    var subDomain: String {
        return "jsonparser"
    }
    
    var failureReason: String {
        switch self {
        case .InvalidValue:
            return "Invalid value found in JSON."
        case .UnexpectedFormat:
            return "Invalid JSON format."
        }
    }
    
}
