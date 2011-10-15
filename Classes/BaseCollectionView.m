#import "BaseCollectionView.h"

#import "SlideCollectionViewItem.h"
#import "ApplicationDelegate.h"
#import "SlideView.h"
#import "Presentation.h"
#import "Slide.h"

@implementation BaseCollectionView

/********************
 * NSCollectionView *
 ********************/

- (NSCollectionViewItem*) newItemForRepresentedObject:(id)object {
  [self setMaxItemSize:NSMakeSize(200, 150)];
  [self setMinItemSize:NSMakeSize(200, 150)];
  SlideView *slideView = [[SlideView alloc] initWithSlide:object andCollectionView:self];
  SlideCollectionViewItem *item = [SlideCollectionViewItem new];
  [item setView:slideView];
  return item;
}

/* Set the Content and select the item according to the given index.
 */
- (void) setContent:(id)newContent andIndex:(NSUInteger)index {
  [self setContent:newContent];
  [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:[index integerValue]]];
}

- (void) deselectAll {
  [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:-1]];
}

/* Really, this should be built-in Cocoa.
 */
- (void) setSelectionIndexes:(NSIndexSet*)indexes {
  [super setSelectionIndexes:indexes];
	[[NSNotificationCenter defaultCenter] postNotificationName:CollectionViewSelectionDidChangeNotification object:self];
}

/******************
 * GETTER METHODS *
 ******************/

/* Fetching the currently displayed presentation.
 */
- (Presentation*) presentation {
  return [[self selectedSlide] presentation];
}

/* Fetching the currently selected slide.
 */
- (Slide*) selectedSlide {
  return [[self content] objectAtIndex:[self selectionIndex]];
}

/* Fetching the selection index. We assume that only one item is selected.
 */
- (NSUInteger) selectionIndex {
  return [[self selectionIndexes] firstIndex];
}

@end