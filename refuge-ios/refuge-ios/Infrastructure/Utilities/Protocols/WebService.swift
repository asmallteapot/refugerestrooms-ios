//
//  WebService.swift
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

/// Web service that facilitates communication with entities on the web that return JSON.
internal protocol WebService {
    
    /// Base URL associated with the service.
    var baseURL: String { get }
    
    /**
     Makes a GET request.
     
     - parameter path:       Path to resource.
     - parameter parameters: Parameters.
     - parameter completion: Completion with JSON when successful, error otherwise.
     */
    func GET(path: String, parameters: [String : AnyObject]?, completion: ([String : AnyObject]?, NSError?) -> ())
    
}
