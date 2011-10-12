#import "LiveviewCollectionView.h"

#import "ApplicationDelegate.h"
#import "ProjectorController.h"

@implementation LiveviewCollectionView

/* This hook updates the projector slide whenever the selection in the Liveview changes.
 */
- (void) afterSelectionChanged {
  //[[NSApp projectorController] setSlide:[self selectedSlide]];
}

@end