//
//  JSON.swift
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

/**
JSON in its various representations.
*/
internal enum JSON {
    
    /// JSON array.
    case Array(value: [[String : AnyObject]])
    
    /// JSON dictionary.
    case Dictionary(value: [String : AnyObject])
    
    // MARK: - Init/Deinit
    
    /**
     Initializes with generic object.
     
     - parameter value: Generic object.
     
     - returns: JSON if object is a valid type, nil otherwise.
     */
    init?(value: AnyObject) {
        if let value = value as? [[String : AnyObject]] {
            self = .Array(value: value)
        } else if let value = value as? [String : AnyObject] {
            self = .Dictionary(value: value)
        } else {
            return nil
        }
    }
    
    /**
     Initializes with dictionary.
     
     - parameter value: Dictionary.
     
     - returns: JSON.
     */
    init(value: [String : AnyObject]) {
        self = .Dictionary(value: value)
    }
    
    /**
     Initializes with array.
     
     - parameter value: Array.
     
     - returns: JSON.
     */
    init(value: [[String : AnyObject]]) {
        self = .Array(value: value)
    }
    
}
