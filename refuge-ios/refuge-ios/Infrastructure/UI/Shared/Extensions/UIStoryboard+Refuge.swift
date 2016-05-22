//
//  UIStoryboard+Refuge.swift
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

extension UIStoryboard {
    
    /**
     Instantiates the given view controller from its storyboard.
     
     - parameter t: Type of view controller to instantiate.
     
     - returns: View controller.
     */
    static func instantiateViewControllerOfType<T: StoryboardInstantiable>(t: T.Type) -> T {
        guard let viewController = T.parentStoryboard.instantiateViewControllerWithIdentifier(T.storyboardIdentifier) as? T else {
            fatalError("Could not instantiate view controller from storyboard.")
        }
        
        return viewController
    }
    
}

// MARK: - Protocol conformance

// MARK: StoryboardAssembly

extension UIStoryboard: StoryboardAssembly {
 
    static func mainStoryboard() -> UIStoryboard {
        return storyboardNamed("Main")
    }
    
    // MARK: Private
    
    private static func storyboardNamed(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
}
