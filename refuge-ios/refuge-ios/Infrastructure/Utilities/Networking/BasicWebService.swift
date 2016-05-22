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

import Foundation

/// Basic web service utilizing NSURLSession.
internal final class BasicWebService: WebService {
    
    // MARK: - Types
    
    /**
     Session cache type.
     */
    enum SessionCacheType {
        /// Disk-persisted global cache, credential and cookie storage objects.
        case Disk
    
        /// Session-related data is stored in memory. i.e. A “private” session.
        case Memory
        
        private func sessionConfiguration() -> NSURLSessionConfiguration {
            switch self {
            case .Disk:
                return NSURLSessionConfiguration.defaultSessionConfiguration()
            case .Memory:
                return NSURLSessionConfiguration.ephemeralSessionConfiguration()
            }
        }
    }
    
    // MARK: - Properties
    
    /// Base URL.
    let baseURL: String
    
    /// JSON reading options.
    let jsonReadingOptions: NSJSONReadingOptions
    
    /// JSON serializer.
    let jsonSerializer: JSONSerializer

    /// Network activity indicator.
    let networkActivityIndicator: NetworkActivityIndicator
    
    /// URL constructor.
    let urlConstructor: WebServiceURLConstructor
    
    // MARK: Private properties
    
    private var session: NSURLSession?
    private var currentTask: NSURLSessionDataTask?
    
    // MARK: - Init/Deinit

    /**
     Creates new instance with provided details. 
     
     Defaults session cache type to Disk and JSON reading options to AllowFragments.
     
     - parameter baseURL:                  Base URL.
     - parameter jsonSerializer:           JSON serializer.
     - parameter networkActivityIndicator: Network activity indicator.
     - parameter urlConstructor:           URL constructor.
     */
    convenience init(baseURL: String, jsonSerializer: JSONSerializer, networkActivityIndicator: NetworkActivityIndicator, urlConstructor: WebServiceURLConstructor) {
        self.init(baseURL: baseURL,
                  jsonReadingOptions: .AllowFragments,
                  jsonSerializer: jsonSerializer,
                  networkActivityIndicator: networkActivityIndicator,
                  sessionCacheType: .Disk,
                  urlConstructor: urlConstructor
        )
    }
    
    /**
     Creates new instance with provided details.
     
     - parameter baseURL:                  Base URL.
     - parameter jsonReadingOptions:       JSON reading options.
     - parameter jsonSerializer:           JSON serializer.
     - parameter networkActivityIndicator: Network activity indicator.
     - parameter sessionCacheType:         Session cache type.
     - parameter urlConstructor:           URL constructor.
     */
    init(baseURL: String, jsonReadingOptions: NSJSONReadingOptions, jsonSerializer: JSONSerializer, networkActivityIndicator: NetworkActivityIndicator, sessionCacheType: SessionCacheType, urlConstructor: WebServiceURLConstructor) {
        self.baseURL = baseURL
        self.jsonReadingOptions = jsonReadingOptions
        self.jsonSerializer = jsonSerializer
        self.networkActivityIndicator = networkActivityIndicator
        self.urlConstructor = urlConstructor
        self.session = NSURLSession(configuration: sessionCacheType.sessionConfiguration())
        self.currentTask = nil
    }
    
    // MARK: - Protocol conformance
    
    // MARK: WebService
    
    func GET(path: String, parameters: [String : AnyObject]?, completion: (AnyObject?, NSError?) -> ()) {
        if currentTask != nil {
            currentTask?.cancel()
        }
        
        let urlString = urlConstructor.constructURLWithBase(baseURL, path: path, parameters: parameters)
        
        guard let url = NSURL(string: urlString) else {
            let errorDescription = "Invalid URL for web service request: \(urlString)"
            let error = NSError(domain: "com.refugerestrooms.refuge-ios.webservice", code: 1, userInfo: [NSLocalizedDescriptionKey : errorDescription])
            
            completion(nil, error)
            return
        }
        
        networkActivityIndicator.start()
        
        currentTask = session?.dataTaskWithURL(url) {
            [weak self] data, response, error in
            
            self?.networkActivityIndicator.stop()
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? NSHTTPURLResponse else {
                let errorDescription = "Invalid web service response but no error indicated."
                let error = NSError(domain: "com.refugerestrooms.refuge-ios.webservice", code: 2, userInfo: [NSLocalizedDescriptionKey : errorDescription])
                
                completion(nil, error)
                return
            }
            
            if httpResponse.statusCode == 204 {
                completion(NSNull(), nil)
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                let errorDescription = "Web service request completed with unexpected status code: \(httpResponse.statusCode)"
                let error = NSError(domain: "com.refugerestrooms.refuge-ios.webservice", code: 3, userInfo: [NSLocalizedDescriptionKey : errorDescription])
                
                completion(nil, error)
                return
            }
            
            if
                let jsonSerializer = self?.jsonSerializer,
                let jsonReadingOptions = self?.jsonReadingOptions {
                let serializationResult = jsonSerializer.serializeDataToJSON(data, readingOptions: jsonReadingOptions)
                
                if let error = serializationResult.error {
                    completion(nil, error)
                    return
                } else {
                    completion(serializationResult.json!, nil)
                }
            }
        }
        
        currentTask?.resume()
    }
    
}