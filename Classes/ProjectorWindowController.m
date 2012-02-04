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
  [self setupWindow];
  [self setupObservers];
}

- (void) setupWindow {
  self.window.movableByWindowBackground = YES;
  self.window.contentSize = [[NSApp projectorController] recommendedThumbnailSize];
  self.window.backgroundColor =[NSColor blackColor];
  self.window.title = NSLocalizedString(@"projector.window.title", nil);
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