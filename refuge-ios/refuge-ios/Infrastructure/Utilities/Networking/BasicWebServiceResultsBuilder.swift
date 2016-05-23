//
//  BasicWebServiceResultsBuilder.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/22/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Basic web service results builder.
internal struct BasicWebServiceResultsBuilder: WebServiceResultsBuilder {
    
    /// JSON reading options.
    let jsonReadingOptions: NSJSONReadingOptions
    
    //. JSON serializer.
    let jsonSerializer: JSONSerializer
    
    // MARK: - Protocol conformance
    
    // MARK: WebServiceResultsBuilder
    
    func ensureNoError(requestResult: (data: NSData?, response: NSURLResponse?, error: NSError?)) -> Result<(data: NSData?, response: NSURLResponse?)> {
        return Result {
            if let error = requestResult.error {
                throw error
            }
            
            return (requestResult.data, requestResult.response)
        }
    }
    
    func ensureHTTPResponseExists(requestResult: (data: NSData?, response: NSURLResponse?)) -> Result<(data: NSData?, response: NSHTTPURLResponse)> {
        return Result {
            guard let response = requestResult.response as? NSHTTPURLResponse else {
                throw WebServiceError.InvalidResponseWithNoError
            }
            
            return (requestResult.data, response)
        }
    }
    
    func ensureSuccessStatusCode(requestResult: (data: NSData?, response: NSHTTPURLResponse)) -> Result<(data: NSData?, statusCode: HTTPResponseStatusCode)> {
        return Result {
            let statusCode = requestResult.response.statusCode
            
            guard let recognizedStatusCode = HTTPResponseStatusCode(rawValue: Int(statusCode)) else {
                throw WebServiceError.StatusCodeUnexpected(statusCode: statusCode)
            }
            
            return (requestResult.data, recognizedStatusCode)
        }
    }
    
    func processRequestData(requestData: (data: NSData?, statusCode: HTTPResponseStatusCode)) -> Result<AnyObject> {
        switch requestData.statusCode {
        case .NoContent:
            return Result(value: NSNull())
        case .OK:
            let serializationResult = jsonSerializer.serializeDataToJSON(requestData.data, readingOptions: jsonReadingOptions)
            
            return serializationResult
        }
    }
    
}
