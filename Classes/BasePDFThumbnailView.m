#import "BasePDFThumbnailView.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"

@implementation BasePDFThumbnailView

- (void) awakeFromNib {
  [self updateThumbnailSize];
}

- (void) updateThumbnailSize {
  [self setThumbnailSize:[[NSApp projectorController] recommendedThumbnailSize]]; 
}

/******************
 * EVENT TRACKING *
 ******************/

- (void) mouseDown:(NSEvent*)event {
  [super mouseDown:event];
  switch ([event clickCount]) {
    case 1: [self wasSingleClicked]; break;
    case 2: [self wasDoubleClicked]; break;
  }
}

- (void) wasSingleClicked {
  [self sendWasClickedNotification:PDFThumbnailViewWasSingleClickedNotification];
}

- (void) wasDoubleClicked {
  [self sendWasClickedNotification:PDFThumbnailViewWasDoubleClickedNotification];
}

- (void) sendWasClickedNotification:(NSString*)notificationName {
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
}

@end
