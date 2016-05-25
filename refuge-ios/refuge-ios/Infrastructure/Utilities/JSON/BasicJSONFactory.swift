//
//  BasicJSONFactory.swift
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

/// Basic JSON factory.
internal struct BasicJSONFactory: JSONFactory {
    
    // MARK: - Properties
    
    /// JSON reading options.
    let jsonReadingOptions: NSJSONReadingOptions
    
    /// JSON serializer.
    let jsonSerializer: JSONSerializer
    
    // MARK: - Protocol conformance
    
    // MARK: JSONFactory
    
    func jsonForHTTPResponse(httpResponse: HTTPResponse) -> Result<JSON> {
        switch httpResponse.statusCode {
        case .NoContent:
            return emptyJSON()
        case .OK:
            return jsonFromData(httpResponse.data)
        }
    }
    
    func emptyJSON() -> Result<JSON> {
        return Result(value: NSNull())
    }
    
    func jsonFromData(data: NSData?) -> Result<JSON> {
        return jsonSerializer.serializeDataToJSON(data, readingOptions: jsonReadingOptions)
    }
    
}
