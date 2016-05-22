//
//  BasicWebServiceURLConstructor.swift
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

/// Basic web service URL constructor.
internal struct BasicWebServiceURLConstructor: WebServiceURLConstructor {
    
    // MARK: - Properties
    
    /// Parameters converter.
    let parametersConverter: WebServiceParametersConverter
    
    // MARK: - Protocol conformance
    
    // MARK: WebServiceURLConstructor
    
    func constructURLWithBase(base: String, path: String, parameters: [String : AnyObject]?) -> String {
        let pathWithParameters = (parameters == nil) ? path : parametersConverter.convertParametersToPath(parameters!, pathRoot: path)
        
        return base + pathWithParameters
    }
    
}
