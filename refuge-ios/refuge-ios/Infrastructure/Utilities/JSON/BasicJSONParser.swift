//
//  BasicJSONParser.swift
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

/// Basic JSON parser.
internal struct BasicJSONParser: JSONParser {
    
    // MARK: - Protocol conformance
    
    // MARK: JSONParser
    
    func restroomsFromJSON(json: JSON) -> Result<[Restroom]> {
        guard case .Array(let jsonArray) = json else {
            let errorDescription = "Cannot parse JSON."
            let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonparser", code: 1, userInfo: [NSLocalizedDescriptionKey : errorDescription])
            
            return Result(error: error)
        }
        
        var restrooms: [Restroom] = []
        
        for json in jsonArray {
            guard let name = json["name"] as? String else {
                let errorDescription = "Cannot parse JSON."
                let error = NSError(domain: "com.refugerestrooms.refuge-ios.jsonparser", code: 1, userInfo: [NSLocalizedDescriptionKey : errorDescription])
                
                return Result(error: error)
            }
            
            let restroom = Restroom(name: name)
            
            restrooms.append(restroom)
        }
        
        return Result(value: restrooms)
    }
    
}
