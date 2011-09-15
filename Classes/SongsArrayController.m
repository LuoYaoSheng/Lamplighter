#import "SongsArrayController.h"

@implementation SongsArrayController

- (id) init {
  debugLog(@"[SongsArrayController] init");
  self = [super init];
  [self setEntityName:@"Song"];
  return self;
}

@end
