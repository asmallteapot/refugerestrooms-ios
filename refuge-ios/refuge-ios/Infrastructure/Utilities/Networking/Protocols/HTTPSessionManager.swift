//
//  HTTPSessionManager.swift
///
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

/// HTTP session manager.
internal protocol HTTPSessionManager {
    
    /// Cancels current request, if one is being made.
    func cancelCurrentRequest()
    
    /**
     Makes an HTTP request with the provided URL.
     
     - parameter url: URL for request.
     - parameter completion: Completion with HTTP response when successful, error otherwise.
     */
    func makeRequestWithURL(url: NSURL, completion: Result<HTTPResponse> -> ())
    
}
