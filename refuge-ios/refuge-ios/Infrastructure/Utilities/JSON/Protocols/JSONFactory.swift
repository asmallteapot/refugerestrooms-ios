//
//  JSONFactory.swift
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

/// Factory producing JSON.
internal protocol JSONFactory {
    
    /**
     JSON for provided HTTP response
     
     - parameter httpResponse: HTTP response.
     
     - returns: JSON when successful, error otherwise.
     */
    func jsonForHTTPResponse(httpResponse: HTTPResponse) -> Result<JSON>
    
    /**
     Empty JSON.
     
     - returns: JSON when successful, error otherwise.
     */
    func emptyJSON() -> Result<JSON>
    
    /**
     JSON from provided data.
     
     - parameter data: Data.
     
     - returns: JSON when successful, error otherwise.
     */
    func jsonFromData(data: NSData?) -> Result<JSON>
    
}
