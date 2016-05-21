//
//  ViewController.swift
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

import UIKit

class ViewController: UIViewController {
    
    var webService: WebService = BasicWebService(
        baseURL: "http://www.refugerestrooms.org:80/api/v1/",
        jsonReadingOptions: .AllowFragments,
        jsonSerializer: BasicJSONSerializer(),
        networkActivityIndicator: BasicNetworkActivityIndicator(),
        sessionCacheType: .Disk,
        urlConstructor: BasicWebServiceURLConstructor(
            parametersConverter: BasicWebServiceParametersConverter()
        )
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webService.GET("restrooms.json", parameters: ["page" : 1, "per_page" : 5]) {
            (json, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            print(json)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

