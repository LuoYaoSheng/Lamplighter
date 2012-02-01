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
  [view setFrame:NSMakeRect(0, 0, self.projectorView.frame.size.width, self.projectorView.frame.size.height)];
  [self.projectorView setSubviews:[NSArray arrayWithObjects: view, nil]];

  

/*
  if ([[NSApp projectorController] isFullScreenMode]) {
    [self goFullscreen:view];
    [self.currentProjectorView exitFullScreenModeWithOptions:NULL];
  } else {
    [self.window setContentView:view];
  }
  self.currentProjectorView = view;
  */
}

- (void) goFullscreen:(NSView*)view {
  // NSNumber *presentationOptions = [NSNumber numberWithUnsignedInt:(NSApplicationPresentationAutoHideMenuBar|NSApplicationPresentationAutoHideDock|NSApplicationPresentationDisableProcessSwitching)];
  NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, NULL, NSFullScreenModeApplicationPresentationOptions, nil];
  [view enterFullScreenMode:[[NSScreen screens] objectAtIndex:1] withOptions:opts];
  [[[NSApp mainWindowController] window] makeKeyWindow];
}

// Notifications

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

// Accessors

- (ProjectorWindow*) window {
  return (ProjectorWindow*)[super window];
}

@end