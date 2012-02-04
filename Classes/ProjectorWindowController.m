#import "ProjectorWindowController.h"

#import <Quartz/Quartz.h>
#import "ApplicationDelegate.h"
#import "ProjectorController.h"
#import "MainWindowController.h"
#import "SlideView.h"
#import "ProjectorWindow.h"
#import "ProjectorPDFView.h"

@implementation ProjectorWindowController

@synthesize pdfView, projectorView;

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[ProjectorWindowController] awakeFromNib");
  [self setupWindow];
  [self setupPDFView];
  [self setupObservers];
}

- (void) setupWindow {
  [self.window setMovableByWindowBackground:YES];
  NSSize size = [[NSApp projectorController] sizeOfProjectorScreen];
  self.window.contentSize = NSMakeSize(250, 250 / (size.width / size.height));
  [self.window setBackgroundColor:[NSColor blackColor]];
}

- (void) setupPDFView {
  self.pdfView = [ProjectorPDFView new];
  self.pdfView.displayMode = kPDFDisplaySinglePage;
  self.pdfView.autoScales = YES;
  self.pdfView.backgroundColor = [NSColor blackColor];
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
  [self showView:(NSView*)[[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection] andPreviewMode:NO]];
}

- (void) updatePDF {
  [self showView:(NSView*)self.pdfView];
}

- (void) showView:(NSView*)view {
  [view setAutoresizingMask:(NSViewMinXMargin|NSViewWidthSizable|NSViewMaxXMargin|NSViewMinYMargin|NSViewHeightSizable|NSViewMaxYMargin)];
  [view setFrame:NSMakeRect(0, 0, view.superview.frame.size.width, view.superview.frame.size.height)];
  [self.projectorView setSubviews:[NSArray arrayWithObjects: view, nil]];
}

- (void) goFullscreen:(NSView*)view {
  // NSNumber *presentationOptions = [NSNumber numberWithUnsignedInt:(NSApplicationPresentationAutoHideMenuBar|NSApplicationPresentationAutoHideDock|NSApplicationPresentationDisableProcessSwitching)];
  NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, NULL, NSFullScreenModeApplicationPresentationOptions, nil];
  [view enterFullScreenMode:[[NSScreen screens] objectAtIndex:1] withOptions:opts];
  [[[NSApp mainWindowController] window] makeKeyWindow];
}

- (void) ensureCorrectFullscreenState { 
  if ([[NSScreen screens] count] == 1) {
    // If there is just one screen, make sure nothing is in fullscreen mode here.
    // This method won't fail if the window is not in fullscreen mode.
    //[self.window setIsVisible:YES];
    [self.window exitFullScreen];
  } else {
    if ([[NSApp projectorController] isLive] && ![self.projectorView isInFullScreenMode]) {
      // If there is a second screen, and we are in live mode, and we are not already in fullscreen mode
      // then go fullscreen on the secondary screen.
      [self.window goFullscreenOnScreen:[[NSScreen screens] objectAtIndex:1]];
      //[self.window setIsVisible:NO];
    }
  }
}

// Notifications

- (void) nsApplicationDidChangeScreenParametersNotification:(NSNotification*)notification {
  [self ensureCorrectFullscreenState];
}

// Accessors

- (ProjectorWindow*) window {
  return (ProjectorWindow*)[super window];
}

@end