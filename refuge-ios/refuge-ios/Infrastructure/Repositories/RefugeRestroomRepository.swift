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
    
    /// Web service request assembly.
    weak var webServiceRequestAssembly: WebServiceRequestAssembly!
    
    // MARK: - Init/Deinit
    
    /**
     Creates new instance with provided details.
     
     - parameter jsonParser:                JSON parser.
     - parameter webService:                Web service.
     - parameter webServiceRequestAssembly: Web service request assembly.
     
     - returns: New instance.
     */
    init(jsonParser: JSONParser, webService: WebService, webServiceRequestAssembly: WebServiceRequestAssembly) {
        self.jsonParser = jsonParser
        self.webService = webService
        self.webServiceRequestAssembly = webServiceRequestAssembly
    }
    
    // MARK: - Protocol conformance
    
    // MARK: RestroomRepository
    
    func fetchLatestRestrooms(cap: Int, completion: Result<[Restroom]> -> ()) {
        let request = webServiceRequestAssembly.fetchLatestRestroomsRequest(cap: cap)
        
        webService.executeRequest(request) {
            result in
            
            switch result {
            case .Success(let value):
                if let _ = value as? NSNull {
                    completion(Result(value: []))
                    return
                }
                
                guard let json = JSON(value: value) else {
                    completion(Result(error: RestroomRepositoryError.InvalidDataFromWebRequest))
                    return
                }
                
                let jsonParserResult = self.jsonParser.restroomsFromJSON(json)
                
                completion(jsonParserResult)
            case .Failure(let error):
                completion(Result(error: error))
            }
        }
    }
    
}
