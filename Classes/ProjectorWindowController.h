@class PDFView;
@class ProjectorWindow;

@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  ProjectorWindow *window;

  IBOutlet PDFView *pdfView;
  IBOutlet NSView *backgroundView;
  
}

@property (nonatomic, retain, readonly) PDFView *pdfView;
@property (nonatomic, retain, readonly) NSView *backgroundView;

- (ProjectorWindow *)window;

// Initialization
- (void) setupWindow;

// Instance Methods
- (BOOL) isWindowVisible;
- (void) updateSlide;
- (void) updatePDF;

@end
