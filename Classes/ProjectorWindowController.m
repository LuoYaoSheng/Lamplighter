#import "ProjectorWindowController.h"

#import <Quartz/Quartz.h>
#import "ApplicationDelegate.h"
#import "ProjectorController.h"
#import "MainWindowController.h"
#import "SlideView.h"
#import "ProjectorWindow.h"

@implementation ProjectorWindowController

@synthesize pdfView, backgroundView;

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
  NSSize size = [[NSApp projectorController] sizeOfProjectorScreen];
  [self.window setContentSize:NSMakeSize(250, 250 / (size.width / size.height))];
  [self.window setBackgroundColor:[NSColor blackColor]];
  [self.pdfView setBackgroundColor:[NSColor blackColor]];
}

- (void) setupObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nsApplicationDidChangeScreenParametersNotification:) name:NSApplicationDidChangeScreenParametersNotification object:nil];
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
  [self setContentView:(NSView*)[[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection] andPreviewMode:NO]];
}

- (void) updatePDF {
  [self setContentView:(NSView*)self.pdfView];
}

- (void) setContentView:(NSView*)contentView {
  NSView *oldContentView = [self.window contentView];
  [self.window setContentView:contentView];
  [oldContentView setHidden:YES];
  if ([oldContentView isInFullScreenMode]) [self.window toggleFullscreen];
}

- (void) nsApplicationDidChangeScreenParametersNotification:(NSNotification*)notification {
  if ([[NSScreen screens] count] == 1) {
    debugLog(@"Hey, possibly you uplugged the projector!");
    [self.window exitFullScreen];
  } else {
    debugLog(@"Hey, possibly you attached the projector!");
    if ([[NSApp projectorController] isLive]) {
      [self.window goFullscreenOnScreen:[[NSScreen screens] objectAtIndex:0]];
    }
  }
}

- (ProjectorWindow*) window {
  return (ProjectorWindow*)[super window];
}

@end