@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  NSView *windowView;
  
}

- (void) setupWindow;

- (void) goLive;
- (void) leaveLive;

@end
