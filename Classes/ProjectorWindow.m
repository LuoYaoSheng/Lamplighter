#import "ProjectorWindow.h"

@implementation ProjectorWindow

- (BOOL)canBecomeKeyWindow {
  return NO;
}

/***********************
 * FULLSCREEN HANDLING *
 ***********************/

- (void) toggleFullscreen {
  debugLog(@"toggle");
  if ([self.contentView isInFullScreenMode]) {
    [self exitFullScreen];
    [NSCursor unhide];
  } else {
    [self goFullscreenOnScreen:[self screen]];
  }
}

- (void) exitFullScreen {
  [self.contentView exitFullScreenModeWithOptions:NULL];
  [self makeFirstResponder:self];
}

- (void) goFullscreenOnScreen:(NSScreen*)screen {
  NSNumber *presentationOptions = [NSNumber numberWithUnsignedInt:(NSApplicationPresentationAutoHideMenuBar|NSApplicationPresentationAutoHideDock|NSApplicationPresentationDisableProcessSwitching)];
  NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, presentationOptions, NSFullScreenModeApplicationPresentationOptions, nil];
  if (![self.contentView isInFullScreenMode]) {
    if (screen == [NSScreen mainScreen]) [NSCursor hide];
    [self.contentView enterFullScreenMode:screen withOptions:opts];
  } else {
    if (screen == [NSScreen mainScreen]) [NSCursor hide];
    [self.contentView exitFullScreenModeWithOptions:NULL];
    [self.contentView enterFullScreenMode:screen withOptions:opts];
  }
}

@end
