//
//  StoryboardInstantiable.swift
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

import UIKit

/// Indicates a UI element that can be instantiated from a Storyboard.
internal protocol StoryboardInstantiable: class {
    
    /// Identifier for UI element
    static var storyboardIdentifier: String { get }
    
    /// Storyboard where element lives.
    static var parentStoryboard: UIStoryboard { get }
    
}

extension StoryboardInstantiable {
    
    /// Returns the name of class as default storyboard identifier.
    static var storyboardIdentifier: String {
        return String(self)
    }
    
}
