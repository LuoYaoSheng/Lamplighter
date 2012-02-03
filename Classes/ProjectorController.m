#import "ProjectorController.h"

#import "ProjectorWindowController.h"
#import "Song.h"
#import "SlideView.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"
#import "BaseCollectionView.h"
#import "ProjectorWindow.h"
#import "ProjectorPDFView.h"

@implementation ProjectorController

/***************************
 * SCREEN SIZE CALCULATION *
 ***************************/

- (NSSize) recommendedThumbnailSize {
  NSSize size = [self sizeOfProjectorScreen];
  CGFloat width = size.width;
  CGFloat height = size.height;
  CGFloat ratio = width / height;
  // Derive the preview slide size from the MainWindow screen size
  NSRect screenRect = [[[[NSApp mainWindowController] window] screen] frame];
  if (ratio > 1) {
    // Make the horizontal projector slide fit into the preview slide constraints
    width = screenRect.size.width / 5;
    height = width / ratio;
  } else {
    // Make the vertical projector slide fit into the preview slide constraints
    height = screenRect.size.height / 6;
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

/****************
 * LIVE HANDING *
 ****************/
 
- (BOOL) isLive {
  return [[self projectorWindowController] isWindowVisible];
}

- (void) toggleLive {
  [self isLive] ? [self leaveLive] : [self goLive];
}

- (void) goLive {
  [[self projectorWindowController] showWindow:self];
  [[self projectorWindowController] ensureCorrectFullscreenState];
  [[NSApp mainWindowController] updateThumbnailSize];
}

- (void) leaveLive {
  [[self projectorWindowController] close];
  [[self projectorWindowController] ensureCorrectFullscreenState];
  [[NSApp mainWindowController] updateThumbnailSize];
}

/************************
 * BLANK SLIDE HANDLING *
 ************************/
 
- (BOOL) isBlank {
  return ([self showsPDF] || [self showsSlide]) ? NO : YES;
}

- (void) goBlank {
  [self setSlide:NULL];
}

- (BOOL) showsPDF {
  return [[[[self projectorWindowController] window] contentView] class] == [ProjectorPDFView class];
}

- (BOOL) showsSlide {
  return [[[NSApp projectorSlideController] content] class] ? YES : NO;
}

// The PDFView does the following manually.

- (void) setSlide:(Slide*)newSlide {
  [[NSApp projectorSlideController] setContent:newSlide];
  [[self projectorWindowController] updateSlide];
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

- (void) PDFThumbnailViewWasDoubleClickedNotification:(NSNotification*)notification {
   [[self projectorWindowController] updatePDF];
}

- (void) PDFViewWasDoubleClickedNotification:(NSNotification*)notification {
  [[self.projectorWindowController window] toggleFullscreen];
}

- (void) slideViewWasDoubleClickedNotification:(NSNotification*)notification {
  SlideView *slideView = [notification object];
  if ([slideView collectionView] == NULL) {
    [[self.projectorWindowController window] toggleFullscreen];
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