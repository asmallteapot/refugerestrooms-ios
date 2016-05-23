//
//  BasicWebServiceResultsBuilder.swift
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

/// Basic web service results builder.
internal struct BasicWebServiceResultsBuilder: WebServiceResultsBuilder {
    
    /// JSON reading options.
    let jsonReadingOptions: NSJSONReadingOptions
    
    //. JSON serializer.
    let jsonSerializer: JSONSerializer
    
    // MARK: - Protocol conformance
    
    // MARK: WebServiceResultsBuilder
    
    func ensureNoError(requestResult: (data: NSData?, response: NSURLResponse?, error: NSError?)) -> Result<(data: NSData?, response: NSURLResponse?)> {
        return Result {
            if let error = requestResult.error {
                throw error
            }
            
            return (requestResult.data, requestResult.response)
        }
    }
    
    func ensureHTTPResponseExists(requestResult: (data: NSData?, response: NSURLResponse?)) -> Result<(data: NSData?, response: NSHTTPURLResponse)> {
        return Result {
            guard let response = requestResult.response as? NSHTTPURLResponse else {
                throw WebServiceError.InvalidResponseWithNoError
            }
            
            return (requestResult.data, response)
        }
    }
    
    func ensureExpectedStatusCode(requestResult: (data: NSData?, response: NSHTTPURLResponse)) -> Result<(data: NSData?, statusCode: HTTPResponseStatusCode)> {
        return Result {
            let statusCode = requestResult.response.statusCode
            
            guard let recognizedStatusCode = HTTPResponseStatusCode(rawValue: Int(statusCode)) else {
                throw WebServiceError.StatusCodeUnexpected(statusCode: statusCode)
            }
            
            return (requestResult.data, recognizedStatusCode)
        }
    }
    
    func serializeDataToJSON(requestData: (data: NSData?, statusCode: HTTPResponseStatusCode)) -> Result<JSON> {
        switch requestData.statusCode {
        case .NoContent:
            return Result(value: NSNull())
        case .OK:
            let serializationResult = jsonSerializer.serializeDataToJSON(requestData.data, readingOptions: jsonReadingOptions)
            
            return serializationResult
        }
    }
    
}
