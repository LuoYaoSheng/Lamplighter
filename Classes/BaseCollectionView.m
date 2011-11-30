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
  [self resizePreviewSlidesAccordingTo:[[NSApp projectorController] recommendedThumbnailSize]];
}

- (void) resizePreviewSlidesAccordingTo:(NSSize)size {
  [self setMaxItemSize:NSMakeSize(size.width, size.height)];
  [self setMinItemSize:NSMakeSize(size.width, size.height)];
}

/* Set the Content and select the item according to the given index.
 */
- (void) setContent:(id)newContent andIndex:(NSUInteger)index {
  [self setContent:newContent];
  [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:index]];
}

/**********************
 * SELECTION HANDLING *
 **********************/

/* Returns YES or NO depending on whether something happened. YES means, there was a selection and
 * it is now gone. NO means that nothing was selected from the beginning.
 */
- (BOOL) deselectAll {
  if ([[self selectionIndexes] count] > 0) {
    [self setSelectionIndexes:[NSIndexSet indexSet]];
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