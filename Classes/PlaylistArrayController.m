#import "PlaylistArrayController.h"

@implementation PlaylistArrayController

- (id) init {
  debugLog(@"[PlaylistArrayController] init");
  self = [super init];
  [self setEntityName:@"Song"];
  return self;
}

@end
