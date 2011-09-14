#import "SongsArrayController.h"

@implementation SongsArrayController

- (id) init {
  NSLog(@"[SongsArrayController] init");
  self = [super init];
  [self setEntityName:@"Song"];
  return self;
}

@end
