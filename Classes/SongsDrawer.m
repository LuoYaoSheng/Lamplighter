#import "SongsDrawer.h"

@implementation SongsDrawer


- (id)initWithContentSize:(NSSize)size preferredEdge:(NSRectEdge)edge {
  debugLog(@"[SongsDrawer] initWithContentSize"); 
  self = [super initWithContentSize:size preferredEdge:edge];
  return self;
}

@end
