#import "ProjectorPDFView.h"

@implementation ProjectorPDFView

/******************
 * EVENT TRACKING *
 ******************/

- (void) mouseDown:(NSEvent*)event {
  [super mouseDown:event];
  switch ([event clickCount]) {
    case 2: [self wasDoubleClicked]; break;
  }
}

- (void) wasDoubleClicked {
  [self sendWasClickedNotification:PDFViewWasDoubleClickedNotification];
}

- (void) sendWasClickedNotification:(NSString*)notificationName {
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
}

@end
