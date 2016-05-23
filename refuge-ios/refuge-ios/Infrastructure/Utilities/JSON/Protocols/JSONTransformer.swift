//
//  JSONTransformer.swift
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

/// Transforms geneic JSON into more specific form.
internal protocol JSONTransformer {
    
    /**
     Transforms generic JSON to JSON array.
     
     - parameter json: JSON to transform.
     
     - returns: JSON array when successful, error otherwise.
     */
    func toArray(json: JSON) -> Result<JSONArray>
    
    /**
     Transforms generic JSON to JSON dictionary.
     
     - parameter json: JSON to transform.
     
     - returns: JSON dictionary when successful, error otherwise.
     */
    func toDictionary(json: JSON) -> Result<JSONDictionary>
    
}
