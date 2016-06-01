//
//  BasicWebService.swift
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

import Foundation

/// Basic web service.
internal final class BasicWebService: WebService {
    
    // MARK: - Types
    
    // MARK: - Properties
    
    /// Base URL.
    let baseURL: String
    
    /// HTTP session manager.
    let httpSessionManager: HTTPSessionManager
    
    /// JSON factory.
    let jsonFactory: JSONFactory

    /// Network activity indicator.
    let networkActivityIndicator: NetworkActivityIndicator
    
    /// URL constructor.
    let urlConstructor: WebServiceURLConstructor
    
    // MARK: - Init/Deinit

    /**
     Creates new instance with provided details.
     
     - parameter baseURL:                  Base URL.
     - parameter httpSessionManager:       HTTP session manager.
     - parameter jsonFactory:              JSON factory.
     - parameter networkActivityIndicator: Network activity indicator.
     - parameter urlConstructor:           URL constructor.
     
     - returns: New instance.
     */
    init(baseURL: String, httpSessionManager: HTTPSessionManager, jsonFactory: JSONFactory, networkActivityIndicator: NetworkActivityIndicator, urlConstructor: WebServiceURLConstructor) {
        self.baseURL = baseURL
        self.httpSessionManager = httpSessionManager
        self.jsonFactory = jsonFactory
        self.networkActivityIndicator = networkActivityIndicator
        self.urlConstructor = urlConstructor
    }
    
    /// Called on deinitialization.
    deinit {
        httpSessionManager.cancelCurrentRequest()
        networkActivityIndicator.stop()
    }
    
    // MARK: - Protocol conformance
    
    // MARK: WebService
    
    func executeRequest(request: WebServiceRequest, completion: Result<JSON> -> ()) {
        httpSessionManager.cancelCurrentRequest()
        
        let urlString = urlConstructor.constructURLWithBase(baseURL, path: request.path, parameters: request.parameters)
        
        guard let url = NSURL(string: urlString) else {
            completion(Result(error: WebServiceError.InvalidURL(url: urlString)))
            return
        }
        
        let completionForRequest: Result<HTTPResponse> -> () = {
            [weak self] result in
            
            self?.networkActivityIndicator.stop()
            
            switch result {
            case .Success(let httpResponse):
                if let strongSelf = self {
                    completion(strongSelf.jsonFactory.jsonForHTTPResponse(httpResponse))
                }
            case .Failure(let error):
                completion(Result(error: error))
            }
        }
        
        networkActivityIndicator.start()
        
        switch request.method {
        case .GET:
            httpSessionManager.GET(url, completion: completionForRequest)
        }
    }
    
}
