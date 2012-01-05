#import <Quartz/Quartz.h>

@interface ProjectorPDFView : PDFView

- (void) wasDoubleClicked;
- (void) sendWasClickedNotification:(NSString*)notificationName;

@end
