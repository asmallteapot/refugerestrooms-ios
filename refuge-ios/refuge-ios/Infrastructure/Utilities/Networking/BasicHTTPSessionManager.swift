//
//  BasicHTTPSessionManager.swift
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

/// Basic HTTP session manager, utilizing NSURLSession.
internal final class BasicHTTPSessionManager: HTTPSessionManager {
    
    // MARK: - Properties
    
    /// Session.
    let session: NSURLSession
    
    // MARK: Private properties
    
    private var currentTask: NSURLSessionDataTask?
    
    /**
     Creates new instance with provided details.
     
     - parameter session: Session to use for requests.
     
     - returns: New instance.
     */
    init(session: NSURLSession) {
        self.session = session
        self.currentTask = nil
    }
    
    // MARK: - Protocol conformance
    
    // MARK: HTTPSessionManager
    
    func cancelCurrentRequest() {
        switch currentTask {
        case .Some(let task):
            task.cancel()
        case .None:
            return
        }
    }
    
    func GET(url: NSURL, completion: Result<HTTPResponse> -> ()) {
        currentTask = session.dataTaskWithURL(url) {
            (data, response, error) in
            
            if let error = error {
                completion(Result(error: error))
                return
            }
            
            guard let response = response as? NSHTTPURLResponse else {
                completion(Result(error: HTTPSessionManagerError.InvalidResponseWithNoError))
                return
            }
            
            let statusCode = response.statusCode
            
            guard let recognizedStatusCode = HTTPResponse.StatusCode(rawValue: Int(response.statusCode)) else {
                completion(Result(error: HTTPSessionManagerError.StatusCodeUnexpected(statusCode: statusCode)))
                return
            }
            
            let httpResponse = HTTPResponse(data: data, statusCode: recognizedStatusCode)
            
            completion(Result(value: httpResponse))
        }
        
        currentTask?.resume()
    }
    
}
