//
//  InfrastructureAssembly.swift
//  refuge-ios
//
//  Created by Harlan Kellaway on 5/22/16.
//  Copyright © 2016 Harlan Kellaway. All rights reserved.
//

import UIKit

internal protocol InfrastructureAssembly: UIAssembly, UtilityAssembly { }

internal protocol UIAssembly {
    
    func viewController() -> ViewController
    
}

internal protocol UtilityAssembly {
    
    func jsonSerializer() -> JSONSerializer
    
    func networkActivityIndicator() -> NetworkActivityIndicator
    
    func webService(baseURL baseURL: String) -> WebService
    
    func webServiceURLConstructor() -> WebServiceURLConstructor
    
}

extension AppAssembly {
    
    // MARK: - Protocol conformance
    
    // MARK: UIAssembly
    
    func viewController() -> ViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        viewController.webService = webService(baseURL: "http://www.refugerestrooms.org:80/api/v1/")
        
        return viewController
    }
    
    // MARK: UtilityAssembly
    
    func jsonSerializer() -> JSONSerializer {
        return BasicJSONSerializer()
    }
    
    func networkActivityIndicator() -> NetworkActivityIndicator {
        return BasicNetworkActivityIndicator()
    }
    
    func webService(baseURL baseURL: String) -> WebService {
        return BasicWebService(
            baseURL: baseURL,
            jsonSerializer: jsonSerializer(),
            networkActivityIndicator: networkActivityIndicator(),
            urlConstructor: webServiceURLConstructor()
        )
    }
    
    func webServiceURLConstructor() -> WebServiceURLConstructor {
        return BasicWebServiceURLConstructor(parametersConverter: webServiceParametersConverter())
    }
    
    // MARK: - Private
    
    private func webServiceParametersConverter() -> WebServiceParametersConverter {
        return BasicWebServiceParametersConverter()
    }
    
}
