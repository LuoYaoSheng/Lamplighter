@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

}

// Initialization
- (void) setupWindow;

// Instance Methods
- (BOOL) isWindowVisible;
- (void) updateSlide;

@end
