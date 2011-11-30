#import "PreviewPDFThumbnailView.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"

@implementation PreviewPDFThumbnailView


- (void) viewWillDraw {
  [self setThumbnailSize:[[NSApp projectorController] recommendedThumbnailSize]];
}

@end
