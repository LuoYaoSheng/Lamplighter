#import "ProjectorView.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"

@implementation ProjectorView

/* The background view of the Projector is an instance of this class.
 * We want it to be black. After all, because when one slide (i.e. subview)
 * is replaced by another, nobody will see the screen flashing up brightly for a millisecond.
 */
- (void) drawRect:(NSRect)rect {
  [[NSColor blackColor] set];
  [NSBezierPath fillRect: [self bounds]];
}

- (void) toggleFullscreen {
  if ([self isInFullScreenMode]) {
    [self exitFullscreen];
  } else {
    [self goFullscreen];
  }
}

- (void) goFullscreen {
  NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, NULL, NSFullScreenModeApplicationPresentationOptions, nil];
  [self enterFullScreenMode:[NSApp suggestedScreenForProjector] withOptions:opts];
  [[[NSApp mainWindowController] window] makeKeyWindow];
}

- (void) exitFullscreen {
  [self exitFullScreenModeWithOptions:NULL];
}


@end
