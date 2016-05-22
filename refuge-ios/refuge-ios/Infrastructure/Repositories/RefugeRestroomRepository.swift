//
//  RefugeRestroomRepository.swift
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

/// Restroom repository hosted online by the REFUGE project.
internal struct RefugeRestroomRepository: RestroomRepository {
    
    // MARK: - Properties
    
    /// JSON parser.
    let jsonParser: JSONParser
    
    /// Web service.
    let webService: WebService
    
    // MARK: - Protocol conformance
    
    // MARK: RestroomRepository
    
    func fetchLatestRestrooms(cap: Int, completion: ([Restroom]?, NSError?) -> ()) {
        webService.GET("restrooms.json", parameters: ["page" : 1, "per_page" : cap]) {
            (json, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            let jsonParserResult = self.jsonParser.restroomsFromJSON(json!)
            
            if let parserError = jsonParserResult.error {
                completion(nil, parserError)
                return
            }
            
            completion(jsonParserResult.restrooms, nil)
        }
    }
    
}
