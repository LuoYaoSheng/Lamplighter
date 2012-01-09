#import <CoreData/CoreData.h>

@class PDF;

@interface PDF : NSManagedObject {}

// Attributes
@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *url;

@end