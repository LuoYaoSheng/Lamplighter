#import "ProjectorWindowController.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"

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

- (void) goLive {
  debugLog(@"yep");
  [self.window orderFront:self];
}

- (void) leaveLive {
  [self.window close];

}

- (void) windowWillClose:(NSNotification*)notification {
  [[NSApp projectorController] projectorWindowWillClose];   
}

@end