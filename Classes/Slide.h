#import <CoreData/CoreData.h>

@class Presentation;

@interface Slide :  NSManagedObject {}

// Attributes
@property (nonatomic) NSString* content;
@property (nonatomic) NSNumber* position; // Because associated DataCore objects are unordered
@property (nonatomic) Presentation* presentation;

// Instance Methods
- (int) numberOfLines;

@end