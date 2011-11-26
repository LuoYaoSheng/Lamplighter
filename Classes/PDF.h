#import <CoreData/CoreData.h>

@class PDF;

@interface PDF : NSManagedObject {}

// Attributes
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSURL *url;

@end