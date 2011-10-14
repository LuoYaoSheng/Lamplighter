#import "ProjectorWindowController.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"
#import "SlideView.h"

@implementation ProjectorWindowController

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[ProjectorWindowController] awakeFromNib");
  [self setupWindow];
}

- (void) setupWindow {
  BOOL yesBool = YES;
  [self.window performSelector:@selector(setBecomesKeyOnlyIfNeeded:) withObject:[NSNumber numberWithBool:yesBool]];
}

/********************
 * INSTANCE METHODS *
 ********************/

- (BOOL) isWindowVisible {
  return [self.window isVisible];
}

- (void) updateWindow {
  SlideView *slideView = [[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection] andBoxing:NO];
  [self.window setContentView:slideView];
  [self.window orderFront:self];
}

@end