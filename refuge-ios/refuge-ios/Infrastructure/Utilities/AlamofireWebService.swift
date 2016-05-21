//
//  AlamofireWebService.swift
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

import Alamofire
import Foundation

/// Alamofire web service.
internal struct AlamofireWebService: WebService {

    /// Base URL associated with the service.
    let baseURL: String
    
    /// JSON serializer.
    let jsonSerializer: JSONSerializer
    
    /// Parameters converter.
    let parametersConverter: WebServiceParametersConverter
    
    // MARK: - Protocol conformance
    
    // MARK: WebService
    
    func GET(path: String, parameters: [String : AnyObject]?, completion: (AnyObject?, NSError?) -> ()) {
        let pathWithParameters = parametersConverter.convertParametersToPath(parameters, pathRoot: path)
        
        requestWithMethod(.GET, path: pathWithParameters, parameters: nil, encoding: .JSON, completion: completion)
    }
    
    // MARK: - Instance functions
    
    // MARK: Private instance functions
    
    private func requestWithMethod(method: Alamofire.Method, path: String, parameters: [String : AnyObject]?, encoding: Alamofire.ParameterEncoding, completion: (AnyObject?, NSError?) -> ()) {
        let url = urlStringWithBase(baseURL, path: path)
        
        Alamofire.request(method, url, parameters: nil, encoding: encoding, headers: nil).response {
            (request, response, data, error) in
            
            if let error = error {
                completion(nil, error)
                return
            } else {
                let serializationResult = self.jsonSerializer.serializeDataToJSON(data, readingOptions: .AllowFragments)
                
                if let error = serializationResult.error {
                    completion(nil, error)
                    return
                } else {
                    completion(serializationResult.json!, nil)
                }
                
            }
        }
    }
    
    private func urlStringWithBase(base: String, path: String) -> String {
        return base + path
    }
    
}
