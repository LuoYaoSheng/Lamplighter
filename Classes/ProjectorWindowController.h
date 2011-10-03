@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  IBOutlet NSView *slideContainerView;
  
}

@property (nonatomic, retain, readonly) NSView *slideContainerView;


- (void) setupWindow;

- (void) goLive;
- (void) leaveLive;

@end
