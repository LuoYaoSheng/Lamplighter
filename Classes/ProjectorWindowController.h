@class ProjectorPDFView;
@class ProjectorWindow;

@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  ProjectorWindow *window;

  ProjectorPDFView *pdfView;
  IBOutlet NSView *projectorView;
  
}

@property (nonatomic, readwrite, strong) ProjectorPDFView *pdfView;
@property (nonatomic, readwrite) NSView *projectorView;

- (ProjectorWindow *)window;

// Initialization
- (void) setupWindow;
- (void) setupPDFView;
- (void) setupObservers;

// Instance Methods
- (BOOL) isWindowVisible;
- (void) updateSlide;
- (void) updatePDF;
- (void) ensureCorrectFullscreenState;

@end
