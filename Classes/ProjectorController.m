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
    [self goBlank];
  } else {
    [self setSlide:[[[collectionView itemAtIndex:selectionIndex] view] slide]];
  }
}

- (void) slideWasDoubleClickedNotification:(NSNotification*)notification {
  SlideView *slideView = [notification object];
  if ([slideView collectionView] == NULL) {
    [slideView toggleFullscreen];
  }
}

/********************
 * INSTANCE METHODS *
 ********************/

- (BOOL) isBlank {
  if ([[NSApp projectorSlideController] content]) return NO; else return YES;
}

- (void) goBlank {
  [self setSlide:NULL];
}

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