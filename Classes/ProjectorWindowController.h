@class PDFView;

@interface ProjectorWindowController : NSWindowController <NSWindowDelegate> {

  IBOutlet PDFView *pdfView;
  IBOutlet NSView *backgroundView;
  
}

@property (nonatomic, retain, readonly) PDFView *pdfView;
@property (nonatomic, retain, readonly) NSView *backgroundView;

// Initialization
- (void) setupWindow;

// Instance Methods
- (BOOL) isWindowVisible;
- (void) updateSlide;
- (void) updatePDF;

@end
