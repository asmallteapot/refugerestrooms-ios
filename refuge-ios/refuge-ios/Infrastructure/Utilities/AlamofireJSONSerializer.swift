//
//  AlamofireJSONSerializer.swift
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

import Alamofire
import Foundation

/// Alamofire JSON serializer.
internal struct AlamofireJSONSerializer: JSONSerializer {
    
    // MARK: - Protocol conformance
    
    // MARK: JSONSerializer
    
    /**
     Serializes data to JSON.
     
     - parameter data:           Data to serialize.
     - parameter readingOptions: Reading options.
     
     - returns: JSON when successful, error otherwise.
     */
    func serializeDataToJSON(data: NSData?, readingOptions: NSJSONReadingOptions) -> (json: AnyObject?, error: NSError?) {
        let serialized = Alamofire.Request.JSONResponseSerializer(options: readingOptions).serializeResponse(nil, nil, data, nil)
        
        switch serialized {
        case .Success(let json):
            return (json, nil)
        case .Failure(let error):
            return (nil, error)
        }
    }
    
}
