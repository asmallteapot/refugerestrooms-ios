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
    
    /// Success with value.
    case Success(Value)
    
    /// Failure with error.
    case Failure(Error)
    
    // MARK: - Init/Deinit
    
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
    
    // MARK: - Instance functions
    
    /**
     Flat map transform.
     
     - parameter f: Transform function.
     
     - returns: New Result created from appling function to original Result value.
     */
    func flatMap<U>(f: T -> Result<U>) -> Result<U> {
        switch self {
        case .Success(let t):
            return f(t)
        case .Failure(let err):
            return .Failure(err)
        }
    }
    
    /**
     Map transform.
     
     - parameter f: Transform function.
     
     - returns: New Result created from applying function to original Result value.
     */
    func map<U>(f: T -> U) -> Result<U> {
        switch self {
        case .Success(let t):
            return .Success(f(t))
        case .Failure(let err):
            return .Failure(err)
        }
    }
    
    // Return the value if it's a .Success or throw the error if it's a .Failure
    
    /**
     Returns the value if Success, otherwise throws the error.
     
     - returns: Value when successful, throws error otherwise.
     */
    func resolve() throws -> T {
        switch self {
        case Result.Success(let value):
            return value
        case Result.Failure(let error):
            throw error
        }
    }
    
}
