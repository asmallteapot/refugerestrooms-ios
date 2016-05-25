//
//  InfrastructureAssembly.swift
//
// Copyleft (c) 2016 Refuge Restrooms
//
// Refuge is licensed under the GNU AFFERO GENERAL PUBLIC LICENSE
// Version 3, 19 November 2007
//
// This notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

/// Assembles objects used in Infrastructure layer.
internal protocol InfrastructureAssembly: RepositoryAssembly, UIAssembly, UtilityAssembly { }

/// Assembles repository objects.
internal protocol RepositoryAssembly {
    
    /**
     Restroom repository.
     
     - returns: Restroom repository.
     */
    func restroomRepository() -> RestroomRepository
    
}

/// Asesmbles objects related to the UI.
internal protocol UIAssembly: ViewControllerAssembly {
    
}

/// Assembles Storyboard objects.
internal protocol StoryboardAssembly {
    
    /**
     Main storyboard.
     
     - returns: Storyboard.
     */
    static func mainStoryboard() -> UIStoryboard
    
}

/// Assembles View Controller objects.
internal protocol ViewControllerAssembly {
    
    /**
     View controller.
     
     - returns: View controller.
     */
    func viewController() -> ViewController
    
}

/// Assembles utility objects.
internal protocol UtilityAssembly: WebServiceRequestAssembly {

    /// HTTP session manager.
    func httpSessionManager() -> HTTPSessionManager
    
    /**
     JSON parser.
     
     - returns: JSON parser.
     */
    func jsonParser() -> JSONParser
    
    /**
     JSON factory.
     
     - returns: JSON factory.
     */
    func jsonFactory() -> JSONFactory

    /**
     JSON transformer.
     
     - returns: JSON transformer.
     */
    func jsonTransformer() -> JSONTransformer
    
    /**
     Network activity indicator.
     
     - returns: Network activity indicator.
     */
    func networkActivityIndicator() -> NetworkActivityIndicator
    
    /**
     Web service with provided base URL.
     
     - parameter baseURL: Base URL.
     
     - returns: Web service.
     */
    func webService(baseURL baseURL: String) -> WebService
    
    /**
     Web service URL constructor.
     
     - returns: Web service URL constructor.
     */
    func webServiceURLConstructor() -> WebServiceURLConstructor
    
}

/// Assembles web service requests.
internal protocol WebServiceRequestAssembly: class {
    
    /**
     Web service request to fetch latest restrooms.
     
     - parameter cap: Maximum number of restrooms to fetch.
     
     - returns: Web service request.
     */
    func fetchLatestRestroomsRequest(cap cap: Int) -> WebServiceRequest
    
}


extension AppAssembly {
    
    // MARK: - RepositoryAssembly
    
    func restroomRepository() -> RestroomRepository {
        return RefugeRestroomRepository(
            jsonParser: jsonParser(),
            webService: webService(baseURL: "http://www.refugerestrooms.org:80/api/v1/"),
            webServiceRequestAssembly: self
        )
    }
    
    // MARK: - UIAssembly
    
    // MARK: ViewControllerAssembly
    
    func viewController() -> ViewController {
        let viewController = UIStoryboard.instantiateViewControllerOfType(ViewController)
        
        viewController.restroomRepository = restroomRepository()
        
        return viewController
    }
    
    // MARK: - UtilityAssembly
    
    func httpSessionManager() -> HTTPSessionManager {
        return BasicHTTPSessionManager(session: session())
    }
    
    func jsonFactory() -> JSONFactory {
        return BasicJSONFactory(
            jsonReadingOptions: .AllowFragments,
            jsonSerializer: jsonSerializer()
        )
    }
    
    func jsonParser() -> JSONParser {
        return BasicJSONParser(jsonTransformer: jsonTransformer())
    }
    
    func jsonTransformer() -> JSONTransformer {
        return BasicJSONTransformer()
    }
    
    func networkActivityIndicator() -> NetworkActivityIndicator {
        return BasicNetworkActivityIndicator()
    }
    
    func webService(baseURL baseURL: String) -> WebService {
        return BasicWebService(
            baseURL: baseURL,
            httpSessionManager: httpSessionManager(),
            jsonFactory: jsonFactory(),
            networkActivityIndicator: networkActivityIndicator(),
            urlConstructor: webServiceURLConstructor()
        )
    }
    
    func webServiceURLConstructor() -> WebServiceURLConstructor {
        return BasicWebServiceURLConstructor(parametersConverter: webServiceParametersConverter())
    }
    
    // MARK: WebServiceRequestAssembly
    
    func fetchLatestRestroomsRequest(cap cap: Int) -> WebServiceRequest {
        return BasicWebServiceRequest(
            method: .GET,
            path: "restrooms.json",
            parameters: ["page" : 1, "per_page" : cap]
        )
    }
    
    // MARK: - Private
    
    private func jsonSerializer() -> JSONSerializer {
        return BasicJSONSerializer()
    }
    
    private func session() -> NSURLSession {
        return NSURLSession(configuration: sessionConfiguration(shouldSaveToDisk: true))
    }
    
    private func sessionConfiguration(shouldSaveToDisk shouldSaveToDisk: Bool) -> NSURLSessionConfiguration {
        switch shouldSaveToDisk {
        case true:
            return NSURLSessionConfiguration.defaultSessionConfiguration()
        case false:
            return NSURLSessionConfiguration.ephemeralSessionConfiguration()
        }
    }
    
    private func webServiceParametersConverter() -> WebServiceParametersConverter {
        return BasicWebServiceParametersConverter()
    }
    
}
