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

    /// Network activity indicator.
    let networkActivityIndicator: NetworkActivityIndicator
    
    /// Results builder.
    let resultsBuilder: WebServiceResultsBuilder
    
    /// URL constructor.
    let urlConstructor: WebServiceURLConstructor
    
    // MARK: - Init/Deinit

    /**
     Creates new instance with provided details.
     
     - parameter baseURL:                  Base URL.
     - parameter httpSessionManager:       HTTP session manager.
     - parameter networkActivityIndicator: Network activity indicator.
     - parameter resultsBuilder:           Results builder.
     - parameter urlConstructor:           URL constructor.
     
     - returns: New instance.
     */
    init(baseURL: String, httpSessionManager: HTTPSessionManager, networkActivityIndicator: NetworkActivityIndicator, resultsBuilder: WebServiceResultsBuilder, urlConstructor: WebServiceURLConstructor) {
        self.baseURL = baseURL
        self.httpSessionManager = httpSessionManager
        self.networkActivityIndicator = networkActivityIndicator
        self.resultsBuilder = resultsBuilder
        self.urlConstructor = urlConstructor
    }
    
    /// Called on deinitialization.
    deinit {
        if httpSessionManager.isMakingRequest {
            httpSessionManager.cancelCurrentRequest()
        }
        
        if networkActivityIndicator.isRunning {
            networkActivityIndicator.stop()
        }
    }
    
    // MARK: - Protocol conformance
    
    // MARK: WebService
    
    func executeRequest(request: WebServiceRequest, completion: Result<JSON> -> ()) {
        switch request.method {
        case .GET:
            GET(request.path, parameters: request.parameters, completion: completion)
        }
    }
    
    // MARK: - Instance functions
    
    // MARK: Private instance functions
    
    private func GET(path: String, parameters: [String : AnyObject]?, completion: Result<JSON> -> ()) {
        if httpSessionManager.isMakingRequest {
            httpSessionManager.cancelCurrentRequest()
        }
        
        let urlString = urlConstructor.constructURLWithBase(baseURL, path: path, parameters: parameters)
        
        guard let url = NSURL(string: urlString) else {
            completion(Result(error: WebServiceError.InvalidURL(url: urlString)))
            return
        }
        
        if !networkActivityIndicator.isRunning {
            networkActivityIndicator.start()
        }
        
        httpSessionManager.makeRequestWithURL(url) {
            [weak self] (data, response, error) in
            
            if let networkActivityIndicator = self?.networkActivityIndicator where networkActivityIndicator.isRunning {
                networkActivityIndicator.stop()
            }
            
            guard let strongSelf = self else {
                return
            }
            
            let result = Result(value: (data: data, response: response, error: error))
            
            completion(result
                .flatMap(strongSelf.resultsBuilder.ensureNoError)
                .flatMap(strongSelf.resultsBuilder.ensureHTTPResponseExists)
                .flatMap(strongSelf.resultsBuilder.ensureExpectedStatusCode)
                .flatMap(strongSelf.resultsBuilder.serializeDataToJSON)
            )
        }
    }
    
}
