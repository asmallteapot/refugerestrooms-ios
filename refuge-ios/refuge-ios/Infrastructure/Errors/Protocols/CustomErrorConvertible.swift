//
//  CustomErrorConvertible.swift
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

/// Indicates an element that can be converted into an error.
internal protocol CustomErrorConvertible: CustomStringConvertible {
    
    /// Error code.
    var code: Int { get }
    
    /// Failure reason.
    var failureReason: String { get }
    
    /// Sub-domain. 
    /// e.g. In an error domain of com.company.appname.xyz - xyz is the sub-domain.
    var subDomain: String { get }
    
    /**
     Converts to an NSError.
     
     - returns: NSError.
     */
    func toError() -> NSError
    
}

extension CustomErrorConvertible {
    
    var description: String {
        return failureReason
    }
    
    func toError() -> NSError {
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        
        return NSError(
            domain: "\(bundleIdentifier!).\(subDomain)",
            code: code,
            userInfo: [NSLocalizedDescriptionKey : failureReason]
        )
    }
    
}
