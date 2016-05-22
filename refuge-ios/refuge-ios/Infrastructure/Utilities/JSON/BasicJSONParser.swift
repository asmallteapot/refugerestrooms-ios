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
        return Result(value: json)
            .flatMap(ensureArray)
            .flatMap(parseRestrooms)
    }
    
    // MARK: - Instance functions
    
    // MARK: Private instance functions
    
    private func ensureArray(json: JSON) -> Result<[[String : AnyObject]]> {
        return Result {
            guard case .Array(let jsonArray) = json else {
                throw JSONParserError.UnexpectedFormat
            }
            
            return jsonArray
        }
    }
    
    private func parseRestrooms(jsonArray: [[String : AnyObject]]) -> Result<[Restroom]> {
        return Result {
            var restrooms: [Restroom] = []
            
            for json in jsonArray {
                guard let name = json["name"] as? String else {
                    throw JSONParserError.InvalidValue
                }
                
                let restroom = Restroom(name: name)
                
                restrooms.append(restroom)
            }

            return restrooms
        }
    }
    
}
