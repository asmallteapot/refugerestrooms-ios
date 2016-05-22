//
//  Result.swift
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

/// A type that can represent either success with a value or failure with an error.
/// Source: http://alisoftware.github.io/swift/async/error/2016/02/06/async-errors/
internal enum Result<T> {
    
    typealias Value = T
    typealias Error = ErrorType
    
    case Success(Value)
    case Failure(Error)
    
    /**
     Initializes with specified value.
     
     - parameter value: Value.
     
     - returns: Result with value.
     */
    init(value: Value) {
        self = .Success(value)
    }
    
    /**
     Initializes with specified error.
     
     - parameter error: Error.
     
     - returns: Result with error.
     */
    init(error: Error) {
        self = .Failure(error)
    }
    
}
