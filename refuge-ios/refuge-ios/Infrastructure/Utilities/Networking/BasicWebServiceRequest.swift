//
//  BasicWebServiceRequest.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/22/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Basic web service request.
internal struct BasicWebServiceRequest: WebServiceRequest {
    
    // MARK: - Protocol conformance
    
    // MARK: WebServiceRequest
    
    let method: HTTPMethod
    let path: String
    let parameters: [String : AnyObject]?
    
}
