//
//  AlamofireWebService.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/21/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Alamofire
import Foundation

/// Alamofire web service.
internal struct AlamofireWebService: WebService {

    /// Base URL associated with the service.
    let baseURL: String
    
    // MARK: - Protocol conformance
    
    // MARK: WebService
    
    /**
     Makes a GET request.
     
     - parameter path:       Path to resource.
     - parameter parameters: Parameters.
     - parameter completion: Completion with JSON when successful, error otherwise.
     */
    func GET(path: String, parameters: [String : AnyObject]?, completion: (AnyObject?, NSError?) -> ()) {
        requestWithMethod(.GET, path: path, parameters: parameters, encoding: .JSON, completion: completion)
    }
    
    // MARK: - Instance functions
    
    // MARK: Private instance functions
    
    private func requestWithMethod(method: Alamofire.Method, path: String, parameters: [String : AnyObject]?, encoding: Alamofire.ParameterEncoding, completion: (AnyObject?, NSError?) -> ()) {
        let url = urlStringWithBase(baseURL, path: path)
        
        Alamofire.request(method, url, parameters: parameters, encoding: encoding, headers: nil).response {
            (request, response, data, error) in
            
            if let error = error {
                completion(nil, error)
                return
            } else {
                let jsonResult = Alamofire.Request.JSONResponseSerializer(options: .AllowFragments).serializeResponse(nil, nil, data, nil)
                
                switch jsonResult {
                case .Success(let json):
                    completion(json, nil)
                case .Failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    private func urlStringWithBase(base: String, path: String) -> String {
        return base + path
    }
    
}
