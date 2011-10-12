#import <CoreData/CoreData.h>

@class Presentation;

@interface Slide :  NSManagedObject {}

// Attributes
@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSNumber* position; // Because associated DataCore objects are unordered
@property (nonatomic, retain) Presentation* presentation;

// Instance Methods
- (int) numberOfLines;

@end