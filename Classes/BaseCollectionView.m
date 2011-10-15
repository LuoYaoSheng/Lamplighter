#import "BaseCollectionView.h"

#import "SlideCollectionViewItem.h"
#import "ApplicationDelegate.h"
#import "SlideView.h"
#import "Presentation.h"
#import "Slide.h"
#import "ProjectorController.h"

@implementation BaseCollectionView

/********************
 * NSCollectionView *
 ********************/

- (NSCollectionViewItem*) newItemForRepresentedObject:(id)object {
  //[self setMaxItemSize:NSMakeSize(200, 150)];
  //[self setMinItemSize:NSMakeSize(200, 150)];
  [self resizePreviewSlidesAccordingToProjectorViewSize];
  SlideView *slideView = [[SlideView alloc] initWithSlide:object andCollectionView:self];
  SlideCollectionViewItem *item = [SlideCollectionViewItem new];
  [item setView:slideView];
  return item;
}

/*****************
 * ITEM HANDLING *
 *****************/

- (void) resizePreviewSlidesAccordingToProjectorViewSize {
  [self resizePreviewSlidesAccordingTo:[[NSApp projectorController] sizeOfProjectorScreen]];
}

- (void) resizePreviewSlidesAccordingTo:(NSSize)size {
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
  [self setMaxItemSize:NSMakeSize(width, height)];
  [self setMinItemSize:NSMakeSize(width, height)];
}

/* Set the Content and select the item according to the given index.
 */
- (void) setContent:(id)newContent andIndex:(NSUInteger)index {
  [self setContent:newContent];
  [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:[index integerValue]]];
}

/**********************
 * SELECTION HANDLING *
 **********************/

/* Returns YES or NO depending on whether something happened. YES means, there was a selection and
 * it is now gone. NO means that nothing was selected from the beginning.
 */
- (BOOL) deselectAll {
  if ([[self selectionIndexes] count] > 0) {
    [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:[NSIndexSet indexSet]]];
    return YES;
  }
  return NO;
}

/* Really, this should be built-in Cocoa.
 */
- (void) setSelectionIndexes:(NSIndexSet*)indexes {
  [super setSelectionIndexes:indexes];
	[[NSNotificationCenter defaultCenter] postNotificationName:CollectionViewSelectionDidChangeNotification object:self];
}

/****************
 * NOTIFICAIONS *
 ****************/

- (void) projectorSlideViewWillDrawNotification:(NSNotification*)notification {
  [self resizePreviewSlidesAccordingToProjectorViewSize];
}

@end