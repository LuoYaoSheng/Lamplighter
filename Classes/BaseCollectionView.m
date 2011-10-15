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

/*
- (Presentation*) presentation {
  return [[self selectedSlide] presentation];
}

- (Slide*) selectedSlide {
  debugLog(@"selectedSlide", self);
  return [[self content] objectAtIndex:[self selectionIndex]];
}
- (NSUInteger) selectionIndextest {
  debugLog(@"selectionIndex", self);
  if ([[self selectionIndex] count] > 0) {
    return [[self selectionIndexes] firstIndex];
  } else {
    return -1;
  }
}
*/

@end