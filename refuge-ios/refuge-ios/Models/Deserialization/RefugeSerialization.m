//
// RefugeSerialization.m
//
// Copyleft (c) 2015 Refuge Restrooms
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

#import "RefugeSerialization.h"

@import Mantle;
#import "RefugeRestroom.h"

NSString *RefugeSerializationErrorDomain = @"RefugeSerializationErrorDomain";

@implementation RefugeSerialization

#pragma mark - Public methods

+ (NSArray *)deserializeRestroomsFromJSON:(NSArray *)JSON error:(NSError **)error
{
    if (!JSON || ![JSON isKindOfClass:[NSArray class]] || [JSON count] == 0) {
        return nil;
    }
    
    NSError *errorWhileDeserializingJSON;
    NSMutableArray *restrooms = [NSMutableArray new];
    
    for (NSDictionary *restroomJSON in JSON) {
        RefugeRestroom *restroom =
            [RefugeSerialization deserializeRestroomFromJSON:restroomJSON error:&errorWhileDeserializingJSON];
            
        if (errorWhileDeserializingJSON) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            
            [userInfo setObject:errorWhileDeserializingJSON forKey:NSUnderlyingErrorKey];
            
            *error = [NSError errorWithDomain:RefugeSerializationErrorDomain
                                         code:RefugeSerializationErrorDeserializationFromJSONCode
                                     userInfo:userInfo];
        }
        
        if (restroom) {
            [restrooms addObject:restroom];
        }
    }
    
    return [restrooms count] > 0 ? [NSArray arrayWithArray:restrooms] : nil;
}

#pragma mark - Private methods

+ (RefugeRestroom *)deserializeRestroomFromJSON:(NSDictionary *)JSON error:(NSError **)error
{
    NSError *errorWhileDeserializingJSON;
    
    RefugeRestroom *restroom =
        [MTLJSONAdapter modelOfClass:[RefugeRestroom class] fromJSONDictionary:JSON error:&errorWhileDeserializingJSON];
        
    if (errorWhileDeserializingJSON) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
        
        [userInfo setObject:errorWhileDeserializingJSON forKey:NSUnderlyingErrorKey];
        
        *error = [NSError errorWithDomain:RefugeSerializationErrorDomain
                                     code:RefugeSerializationErrorDeserializationFromJSONCode
                                 userInfo:userInfo];
    }
    
    return restroom;
}

@end
