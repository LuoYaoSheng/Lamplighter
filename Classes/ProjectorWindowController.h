@class PDFView;
@class ProjectorWindow;

@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  ProjectorWindow *window;

  IBOutlet PDFView *pdfView;
  NSView *currentProjectorView;
  
}

@property (nonatomic, readonly) PDFView *pdfView;
@property (nonatomic, readwrite) NSView *currentProjectorView;

- (ProjectorWindow *)window;

// Initialization
- (void) setupWindow;

// Instance Methods
- (BOOL) isWindowVisible;
- (void) updateSlide;
- (void) updatePDF;

@end
