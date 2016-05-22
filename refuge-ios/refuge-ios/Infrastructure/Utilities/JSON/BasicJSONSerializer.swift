//
//  BasicJSONSerializer.swift
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

/// Basic JSON serializer utilizing NSJSONSerialization.
internal struct BasicJSONSerializer: JSONSerializer {
    
    // MARK: - Protocol conformance
    
    // MARK: JSONSerializer
    
    func serializeDataToJSON(data: NSData?, readingOptions: NSJSONReadingOptions) -> Result<JSON> {
        guard let data = data else {
            let errorDescription = "JSON serialization failed with nil or zero length input data."
            let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonserializer", code: 1, userInfo: [NSLocalizedDescriptionKey : errorDescription])
            
            return Result(error: error)
        }
        
        var json: AnyObject? = nil
        
        do {
            try json = NSJSONSerialization.JSONObjectWithData(data, options: readingOptions)
        } catch {
            return Result(error: error as NSError)
        }
        
        guard let j = json else {
            let errorDescription = "JSON serialization failed but no error indicated."
            let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonserializer", code: 2, userInfo: [NSLocalizedDescriptionKey : errorDescription])
            
            return Result(error: error)
        }
        
        return Result(value: j)
    }
    
}
