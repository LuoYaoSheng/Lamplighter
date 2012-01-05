@class ProjectorWindow;

@interface ProjectorWindow : NSWindow {
  
}

// Fullscreen handling
- (void) toggleFullscreen;
- (void) exitFullScreen;
- (void) goFullscreenOnScreen:(NSScreen*)screen;

@end
