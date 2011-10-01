#import "ProjectorController.h"

#import "ProjectorWindowController.h"
#import "Song.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"

@implementation ProjectorController

@synthesize isLive;

/********************
 * INSTANCE METHODS *
 ********************/

- (IBAction) toggleLive {
  isLive ? [self leaveLive] :[ self goLive];
}

- (IBAction) goLive {
  [[self projectorWindowController] goLive];
  isLive = YES;
}

- (IBAction) leaveLive {
  [[self projectorWindowController] leaveLive];
  [self afterLeaveLive];
}

- (void) afterLeaveLive {
  isLive = NO;
}

/*************
 * CALLBACKS *
 *************/

- (void) projectorWindowWillClose {
  [self afterLeaveLive];
}

/**********************
 * WINDOW CONTROLLERS *
 **********************/

- (ProjectorWindowController*) projectorWindowController {
  if (projectorWindowController) return projectorWindowController;
	projectorWindowController = [[ProjectorWindowController alloc] initWithWindowNibName:@"ProjectorWindow"];
  return projectorWindowController;
}

@end