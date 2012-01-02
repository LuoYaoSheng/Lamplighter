@class PDFView;

@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  IBOutlet PDFView *pdfView;
  
}

@property (nonatomic, retain, readonly) PDFView *pdfView;

// Initialization
- (void) setupWindow;

// Instance Methods
- (BOOL) isWindowVisible;
- (void) updateSlide;

@end
