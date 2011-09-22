#import "SongsArrayController.h"

@implementation SongsArrayController

- (id) init {
  debugLog(@"[SongsArrayController] init");
  self = [super init];
  [self setAutomaticallyRearrangesObjects:YES];
  [self setAutomaticallyPreparesContent:YES];
  [self setEntityName:@"Song"];
  return self;
}

@end
