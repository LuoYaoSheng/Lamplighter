#import "PreviewPDFThumbnailView.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"

@implementation PreviewPDFThumbnailView

- (void) awakeFromNib {
  [self updateThumbnailSize];
}

- (BOOL) inLiveResize {
  BOOL result = [super inLiveResize];
  if (result) [self updateThumbnailSize];
  return result;
}

- (void) updateThumbnailSize {
  [self setThumbnailSize:[[NSApp projectorController] recommendedThumbnailSize]]; 
}

@end
