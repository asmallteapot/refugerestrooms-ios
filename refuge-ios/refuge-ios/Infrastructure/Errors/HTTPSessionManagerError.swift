//
//  HTTPSessionManagerError.swift
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

/// HTTP sessoin manager error.
internal enum HTTPSessionManagerError: ErrorType {
    
    /// Invalid response for request but no error was indicated.
    case InvalidResponseWithNoError
    
    /// Request returned with unexpected status code.
    case StatusCodeUnexpected(statusCode: NSInteger)
    
}

// MARK: - Protocol conformance

// MARK: CustomErrorConvertible

extension HTTPSessionManagerError: CustomErrorConvertible {
    
    var code: Int {
        switch self {
        case .InvalidResponseWithNoError:
            return 1
        case .StatusCodeUnexpected(_):
            return 2
        }
    }
    
    var subDomain: String {
        return "httpsessionmanager"
    }
    
    var failureReason: String {
        switch self {
        case .InvalidResponseWithNoError:
            return "Invalid web service response but no error indicated."
        case .StatusCodeUnexpected(let statusCode):
            return "Web service request completed with unexpected status code: \(statusCode)"
        }
    }
    
}
