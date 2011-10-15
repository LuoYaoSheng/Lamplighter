#import "LiveviewController.h"

#import "Presentation.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "LiveviewController.h"
#import "SlideView.h"

@implementation LiveviewController

- (void) slideWasDoubleClickedNotification:(NSNotification*)notification {
  SlideView *slideView = [notification object];
  Slide *slide = [slideView slide];
  if ([slideView collectionView] == [[NSApp mainWindowController] previewCollectionView]) {
    // As you can see, we make use of the "position" attribute of the Slide to determine the index of the Slide
    // in the CollectionView. While I believe that this is really smart, there might be edge cases where this
    // doesn't work. One could imagine that the number of slides changes in a Song - but I assume that the
    // CollectionView then updates its content (Slides) and all positions are correct again.
    //NSDictionary *notificationObject = [NSDictionary dictionaryWithObjectsAndKeys:self.slide, @"slide", self.collectionView, @"collectionView", nil];
    [self setPresentation:(Presentation*)[slide presentation] andIndex:(NSUInteger)[slide position]];
  }
}

- (void) setPresentation:(Presentation*)presentation andIndex:(NSUInteger)index {
  [[[NSApp mainWindowController] liveviewCollectionView] setContent:[presentation sortedSlides] andIndex:index];
}

/* If some random Controller told the ProjectorController to go blank, really we want the liveviewCollection
 * to not have anything selected. That's an example case of why we need this "callback" method.
 */
- (BOOL) ensureNoSelection {
  if (![[NSApp projectorController] isLive]) return NO;
  return [[[NSApp mainWindowController] liveviewCollectionView] deselectAll];
}

@end