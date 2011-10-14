#import "ProjectorController.h"

#import "ProjectorWindowController.h"
#import "Song.h"
#import "SlideView.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"

@implementation ProjectorController


- (void) collectionViewSelectionDidChangeNotification:(NSNotification*)notification {
  NSCollectionView *collectionView = [notification object];
  NSUInteger selectionIndex = [[collectionView selectionIndexes] firstIndex];
  if ((int)selectionIndex == -1) {
    [self setSlide:NULL];
  } else {
    [self setSlide:[[[collectionView itemAtIndex:selectionIndex] view] slide]];
  }
}

/********************
 * INSTANCE METHODS *
 ********************/

- (IBAction) toggleLive {
  [self isLive] ? [self leaveLive] :[ self goLive];
}

- (BOOL) isLive {
  return [[self projectorWindowController] isWindowVisible];
}

- (void) goLive {
  [[self projectorWindowController] showWindow:self];
}

- (void) leaveLive {
  [[self projectorWindowController] close];
}

- (void) setSlide:(Slide*)newSlide {
  [[NSApp projectorSlideController] setContent:newSlide];
  [[self projectorWindowController] updateWindow];
}

/**********************
 * WINDOW CONTROLLERS *
 **********************/

- (ProjectorWindowController*) projectorWindowController {
  if (projectorWindowController) return projectorWindowController;
	projectorWindowController = [[ProjectorWindowController alloc] initWithWindowNibName:@"ProjectorWindow"];
  return projectorWindowController;
}

@end