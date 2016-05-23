//
//  JSONParser.swift
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

/// Parses JSON into objects.
internal protocol JSONParser: RestroomJSONParser {
    
    /**
     Parses objects from JSON Array.
     
     - parameter jsonArray: JSON array.
     
     - returns: Result with objects when successful, error otherwise.
     */
    func parseObjectsFromJSONArray<T>(jsonArray: [[String : AnyObject]], parsingFunction: [String : AnyObject] -> Result<T>) -> Result<[T]>
    
}

/// Parses JSON into restroom objects.
internal protocol RestroomJSONParser {
    
    /**
     Parses restroom from provided JSON.
     
     - parameter json: JSON.
     
     - returns: Result with restrooms when successful, error otherwise.
     */
    func restroomFromJSON(json: [String : AnyObject]) -> Result<Restroom>
    
    /**
     Parses restrooms from provided JSON array.
     
     - parameter json: JSON array.
     
     - returns: Result with restrooms when successful, error otherwise.
     */
    func restroomsFromJSONArray(jsonArray: JSON) -> Result<[Restroom]>
    
}