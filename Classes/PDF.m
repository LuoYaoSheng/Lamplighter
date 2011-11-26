#import "PDF.h"

@implementation PDF

@synthesize url;

/********************
 * INSTANCE METHODS *
 ********************/

- (NSString*) title {
  return [url lastPathComponent];
}

- (void) setTitle:(NSString *)newTitle {
}

@end