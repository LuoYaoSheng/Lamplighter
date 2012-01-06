#import "ProjectorWindowController.h"

#import <Quartz/Quartz.h>
#import "ApplicationDelegate.h"
#import "ProjectorController.h"
#import "MainWindowController.h"
#import "SlideView.h"

@implementation ProjectorWindowController

@synthesize pdfView, backgroundView;

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[ProjectorWindowController] awakeFromNib");
  [self setupWindow];
}

- (void) setupWindow {
  [self.window setMovableByWindowBackground:YES];
  NSSize size = [[NSApp projectorController] sizeOfProjectorScreen];
  [self.window setContentSize:NSMakeSize(250, 250 / (size.width / size.height))];
  [self.window setBackgroundColor:[NSColor blackColor]];
  [self.pdfView setBackgroundColor:[NSColor blackColor]];
}

- (void)windowDidResize:(NSNotification *)notification {
  [[NSApp mainWindowController] updateThumbnailSize];
}
/********************
 * INSTANCE METHODS *
 ********************/

- (BOOL) isWindowVisible {
  return [self.window isVisible];
}

- (void) updateSlide {
  SlideView *slideView = [[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection] andPreviewMode:NO];
  [self.window setContentView:slideView];
}

- (void) updatePDF {
  [self.window setContentView:(NSView*)self.pdfView];
}

- (ProjectorWindow*) window {
  return (ProjectorWindow*)[super window];
}

@end