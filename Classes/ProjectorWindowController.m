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
  SlideView *slideView = [[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection]];
  [self.window setContentView:slideView];
  debugLog(@"[self.window] %@", [self.window contentView]);
  [self.window orderFront:self];
}

@end