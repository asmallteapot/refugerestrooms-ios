//
//  NetworkActivityIndicator.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/21/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import Foundation

/// Indicates network activity is occurring.
internal protocol NetworkActivityIndicator {
    
    /// Starts indicating activity.
    func start()
    
    /// Stops indicating activity.
    func stop()
    
}
