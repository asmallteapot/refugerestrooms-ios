//
//  JSONSerializerError.swift
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

/// JSON serializer error.
enum JSONSerializerError: ErrorType {
    
    /// Data was nil or zero in length.
    case NilOrZeroLengthData
    
    /// Serialization failed but no error was indicated.
    case SerializationFailedWithNoError
    
}

// MARK: - Protocol conformance

// MARK: CustomErrorConvertible

extension JSONSerializerError: CustomErrorConvertible {
    
    var code: Int {
        switch self {
        case .NilOrZeroLengthData:
            return 1
        case .SerializationFailedWithNoError:
            return 2
        }
    }
    
    var subDomain: String {
        return "jsonserializer"
    }
    
    var failureReason: String {
        switch self {
        case .NilOrZeroLengthData:
            return "JSON serialization failed with nil or zero length input data."
        case .SerializationFailedWithNoError:
            return "JSON serialization failed but no error indicated."
        }
    }
    
}
