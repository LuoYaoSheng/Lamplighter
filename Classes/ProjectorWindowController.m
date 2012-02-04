#import "ProjectorWindowController.h"

#import <Quartz/Quartz.h>
#import "ApplicationDelegate.h"
#import "ProjectorController.h"
#import "MainWindowController.h"
#import "SlideView.h"
#import "ProjectorWindow.h"
#import "ProjectorPDFView.h"

@implementation ProjectorWindowController

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[ProjectorWindowController] awakeFromNib");
  [self setupWindow];
  [self setupObservers];
}

- (void) setupWindow {
  [self.window setMovableByWindowBackground:YES];
  //NSSize size = [[NSApp projectorController] sizeOfProjectorScreen];
  //self.window.contentSize = NSMakeSize(250, 250 / (size.width / size.height));
  self.window.contentSize = [[NSApp projectorController] recommendedThumbnailSize];
  [self.window setBackgroundColor:[NSColor blackColor]];
}

- (void) setupObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(liveStatusDidChangeNotification:) name:LiveStatusDidChangeNotification object:nil];
}

- (void) windowDidResize:(NSNotification *)notification {
  [[NSApp mainWindowController] updateThumbnailSize];
}

- (void) liveStatusDidChangeNotification:(NSNotification *)notification {
  NSLog(@"obj: %@", [notification object]);
}

/********************
 * INSTANCE METHODS *
 ********************/

- (BOOL) isWindowVisible {
  return [self.window isVisible];
}



// Accessors

- (ProjectorWindow*) window {
  return (ProjectorWindow*)[super window];
}

@end