//
//  WebServiceResultsBuilder.swift
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

/// Builds the result of a web service request.
internal protocol WebServiceResultsBuilder {
    
    /**
     Ensures no error is present in web service request result.
     
     Should be called as Step 1 in the build process.
     
     - parameter requestResult: Request result.
     
     - returns: Request result without error.
     */
    func ensureNoError(requestResult: (data: NSData?, response: NSURLResponse?, error: NSError?)) -> Result<(data: NSData?, response: NSURLResponse?)>
    
    
    /**
     Ensures an HTTP response exists in web service request result.
     
     Should be called as Step 2 in the build process.
     
     - parameter requestResult: Request result.
     
     - returns: Request result with HTTP response.
     */
    func ensureHTTPResponseExists(requestResult: (data: NSData?, response: NSURLResponse?)) -> Result<(data: NSData?, response: NSHTTPURLResponse)>
    
    /**
     Ensures the status code for web service request is successful.
     
     Should be called as Step 3 in the build process.
     
     - parameter requestResult: Request result.
     
     - returns: Request data and status code.
     */
    func ensureSuccessStatusCode(requestResult: (data: NSData?, response: NSHTTPURLResponse)) -> Result<(data: NSData?, statusCode: HTTPResponseStatusCode)>
    
    /**
     Processes web service request data into its final form.
     
     Should be called as Step 4 in the build process.
     
     - parameter requestData: Request data.
     
     - returns: Result of web service request processing data.
     */
    func processRequestData(requestData: (data: NSData?, statusCode: HTTPResponseStatusCode)) -> Result<AnyObject>
    
}
