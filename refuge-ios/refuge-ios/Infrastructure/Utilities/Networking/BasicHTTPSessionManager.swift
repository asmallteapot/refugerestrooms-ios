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
    
    var isMakingRequest: Bool {
        switch currentTask {
        case .Some(let task):
            return task.state == .Running
        case .None:
            return false
        }
    }
    
    func cancelCurrentRequest() {
        currentTask?.cancel()
    }
    
    func makeRequestWithURL(url: NSURL, completion: (NSData?, NSURLResponse?, NSError?) -> ()) {
        currentTask = session.dataTaskWithURL(url) {
            (data, response, error) in
            
            completion(data, response, error)
        }
        
        currentTask?.resume()
    }
    
}
