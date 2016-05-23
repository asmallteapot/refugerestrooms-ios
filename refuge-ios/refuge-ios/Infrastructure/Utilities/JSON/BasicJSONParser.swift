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
internal struct BasicJSONParser: JSONParser, RestroomJSONParser {
    
    // MARK: - Properties

    /// JSON transformer.
    let jsonTransformer: JSONTransformer
    
    // MARK: - Protocol conformance
    
    // MARK: JSONParser
    
    func parseObjectsFromJSONArray<T>(jsonArray: JSONArray, parsingFunction: JSONDictionary -> Result<T>) -> Result<[T]> {
        return Result {
            var objects: [T] = []
            
            for json in jsonArray {
                let result = parsingFunction(json)
                
                do {
                    let object = try result.resolve()
                    
                    objects.append(object)
                } catch {
                    throw error
                }
            }
            
            return objects
        }
    }
    
    // MARK: RestroomJSONParser
    
    func restroomFromJSON(json: JSONDictionary) -> Result<Restroom> {
        return Result {
            guard let name = json["name"] as? String else {
                throw JSONParserError.InvalidValue
            }
            
            return Restroom(name: name)
        }
    }
    
    func restroomsFromJSON(json: JSON) -> Result<[Restroom]> {
        return Result(value: json)
            .flatMap(jsonTransformer.toArray)
            .flatMap(parseRestrooms)
    }
    
    // MARK: - Instance functions
    
    // MARK: Private instance functions
    
    private func parseRestrooms(jsonArray: JSONArray) -> Result<[Restroom]> {
        return parseObjectsFromJSONArray(jsonArray, parsingFunction: restroomFromJSON)
    }
    
}
