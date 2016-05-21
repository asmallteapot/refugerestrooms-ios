//
//  BasicNetworkActivityIndicator.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/21/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import UIKit

/// Basic network activity indicator utilizing UIApplication.
internal struct BasicNetworkActivityIndicator: NetworkActivityIndicator {
    
    // MARK: - Protocol conformance
    
    // MARK: NetworkActivityIndicator
    
    func start() {
        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
    }
    
    func stop() {
        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
}
