#import <Quartz/Quartz.h>

@interface BasePDFThumbnailView : PDFThumbnailView {

}

- (void) updateThumbnailSize;
- (void) wasSingleClicked;
- (void) wasDoubleClicked;
- (void) sendWasClickedNotification:(NSString*)notificationName;

@end
