@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

}

- (void) setupWindow;

- (BOOL) isWindowVisible;
- (void) updateWindow;

@end
