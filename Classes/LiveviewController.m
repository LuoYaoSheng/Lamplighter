#import "LiveviewController.h"

#import "Presentation.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "LiveviewController.h"
#import "ProjectorController.h"
#import "ProjectorWindowController.h"
#import "BaseCollectionView.h"
#import "BasePDFThumbnailView.h"
#import "SlideView.h"
#import "Slide.h"
#import "PDF.h"

@implementation LiveviewController

/* Here we're basically just passing on the request to the CollectionView. Single responsibility concept.
 */
- (void) setPresentation:(Presentation*)presentation andIndex:(NSUInteger)index {
  [[[NSApp mainWindowController] liveviewCollectionView] setHidden:NO];
  [[[NSApp mainWindowController] liveviewPDFThumbnailView] setHidden:YES];
  [[[NSApp mainWindowController] liveviewCollectionView] setContent:[presentation sortedSlides] andIndex:index];
}

- (void) setPDFDocument:(PDFDocument*)pdfDocument andPage:(PDFPage*)pdfPage {
  //debugLog(@"Setting document to page %@", pdfPage);
  [[[NSApp mainWindowController] liveviewPDFThumbnailView] setHidden:NO];
  [[[NSApp mainWindowController] liveviewCollectionView] setHidden:YES];
  PDFView *projectorPDFView = [[[NSApp projectorController] projectorWindowController] pdfView];
  [projectorPDFView setDocument:pdfDocument];
  [projectorPDFView goToPage:pdfPage];
}

/* If some random Controller told the ProjectorController to go blank, really we want the liveviewCollection
 * to not have anything selected. That's an example case of why we need this "callback" method.
 */
- (BOOL) ensureNoSelection {
  return [[[NSApp mainWindowController] liveviewCollectionView] deselectAll];
}

/*****************
 * NOTIFICATIONS *
 *****************/

- (void) slideViewWasDoubleClickedNotification:(NSNotification*)notification {
  SlideView *slideView = [notification object];
  Slide *slide = [slideView slide];
  if ([slideView collectionView] == [[NSApp mainWindowController] previewCollectionView]) {
    // As you can see, we make use of the "position" attribute of the Slide to determine the index of the Slide
    // in the CollectionView. While I believe that this is really smart, there might be edge cases where this
    // doesn't work. One could imagine that the number of slides changes in a Song - but I assume that the
    // CollectionView then updates its content (Slides) and all positions are correct again.
    //NSDictionary *notificationObject = [NSDictionary dictionaryWithObjectsAndKeys:self.slide, @"slide", self.collectionView, @"collectionView", nil];
    [self setPresentation:(Presentation*)[slide presentation] andIndex:(NSUInteger)[[slide position] intValue]];
  }
}

- (void) PDFThumbnailViewWasDoubleClickedNotification:(NSNotification*)notification {
  PDFPage *pdfPage = [[[notification object] PDFView] currentPage];
  PDFDocument *pdfDocument = [pdfPage document];
  [self setPDFDocument:pdfDocument andPage:pdfPage];
}

@end