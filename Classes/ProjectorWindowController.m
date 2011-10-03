#import "ProjectorWindowController.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"
#import "SlideView.h"

@implementation ProjectorWindowController

@synthesize slideContainerView;

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
  SlideView *slideView = [[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection]];
  [slideContainerView addSubview:slideView];
  debugLog(@"slideContainerView: %@", slideContainerView);
  //[slideContainerView setWantsLayer:YES];
  [self.window orderFront:self];
}

- (void) leaveLive {
  [self.window close];
}

- (void) windowWillClose:(NSNotification*)notification {
  [[NSApp projectorController] projectorWindowWillClose];   
}

@end