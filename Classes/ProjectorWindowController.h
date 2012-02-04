@class ProjectorPDFView;
@class ProjectorWindow;

@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  ProjectorWindow *window;
  
}

- (ProjectorWindow *)window;

// Initialization
- (void) setupWindow;

// Instance Methods
- (BOOL) isWindowVisible;

@end
