#import "BaseArrayController.h"

@implementation BaseArrayController

- (id) init {
  NSLog(@"[SongsArrayController] init");
  self = [super init];
  [self setAvoidsEmptySelection:NO];
  [self setAutomaticallyRearrangesObjects:YES];
  [self setAutomaticallyPreparesContent:YES];
  return self;
}

@end
