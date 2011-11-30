#import "ProjectorController.h"

#import "ProjectorWindowController.h"
#import "Song.h"
#import "SlideView.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"
#import "BaseCollectionView.h"

@implementation ProjectorController

/********************
 * INSTANCE METHODS *
 ********************/

- (NSSize) recommendedThumbnailSize {
  NSSize size = [self sizeOfProjectorScreen];
  CGFloat width = size.width;
  CGFloat height = size.height;
  CGFloat ratio = width / height;
  // Derive the preview slide size from the MainWindow screen size
  NSRect screenRect = [[[[NSApp mainWindowController] window] screen] frame];
  if (ratio > 1) {
    // Make the horizontal projector slide fit into the preview slide constraints
    width = screenRect.size.width / 4.5;
    height = width / ratio;
  } else {
    // Make the vertical projector slide fit into the preview slide constraints
    height = screenRect.size.height / 5.5;
    width = height * ratio;
  }
  return NSMakeSize(width, height);
}

- (NSSize) sizeOfProjectorScreen {
  NSRect frame;
  if ([NSApp singleScreenMode] && [self isLive]) {
    frame = [[self.projectorWindowController.window contentView] frame];
  } else {
    frame = [[NSApp suggestedScreenForProjector] frame];
  }
  return NSMakeSize(frame.size.width, frame.size.height);
}

- (BOOL) isBlank {
  if ([[NSApp projectorSlideController] content]) return NO; else return YES;
}

- (void) goBlank {
  [self setSlide:NULL];
}

- (void) toggleLive {
  [self isLive] ? [self leaveLive] :[ self goLive];
}

- (BOOL) isLive {
  return [[self projectorWindowController] isWindowVisible];
}

- (void) goLive {
  [[self projectorWindowController] showWindow:self];
  [[[NSApp mainWindowController] liveviewCollectionView] resizePreviewSlidesAccordingToProjectorViewSize];
  [[[NSApp mainWindowController] previewCollectionView] resizePreviewSlidesAccordingToProjectorViewSize];
}

- (void) leaveLive {
  [[self projectorWindowController] close];
}

- (void) setSlide:(Slide*)newSlide {
  [[NSApp projectorSlideController] setContent:newSlide];
  [[self projectorWindowController] updateWindow];
}

/*****************
 * NOTIFICATIONS *
 *****************/

- (void) collectionViewSelectionDidChangeNotification:(NSNotification*)notification {
  NSCollectionView *collectionView = [notification object];
  NSUInteger selectionIndex = [[collectionView selectionIndexes] firstIndex];
  if ((int)selectionIndex == -1) {
    [self goBlank];
  } else {
    [self setSlide:[(SlideView*)[[collectionView itemAtIndex:selectionIndex] view] slide]];
  }
}

- (void) slideViewWasDoubleClickedNotification:(NSNotification*)notification {
  SlideView *slideView = [notification object];
  if ([slideView collectionView] == NULL) {
    [slideView toggleFullscreen];
  } else {
    if ([slideView collectionView] == [[NSApp mainWindowController] liveviewCollectionView] && ![self isLive]) {
      [self goLive];
    }
  }
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