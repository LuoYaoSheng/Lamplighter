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

/******************
 * SETTER METHODS *
 ******************/

/* Set the Presentation and select the first slide.
 */
- (void) setPresentation:(Presentation*)presentation {
  [self setPresentation:presentation andIndex:0];
}

/* Set the Presentation and select a slide according to the given index.
 */
- (void) setPresentation:(Presentation*)presentation andIndex:(NSUInteger)index {
  [self setContent:[presentation sortedSlides]];
  [self setSelectionIndex:index];
}

/* We override this method to call a post-hook that subclasses can use.
 */
- (void) setSelectionIndexes:(NSIndexSet*)indexes {
  debugLog(@"selecting %@", indexes);
  //if ([[self selectionIndexes] count] == 0 && [self presentation]) {
  //  debugLog(@"Correcting index from nothing to 0");
  //  indexes = [NSIndexSet indexSetWithIndex:1];
  //}
  [super setSelectionIndexes:indexes];
  debugLog(@"GOING");
  //[self sendSelectionDidChangeNotification];
//  [self afterSelectionChanged];
}

- (void) setSelectionIndex:(NSUInteger)index {
  [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:index]];  
}

/*********
 * HOOKS *
 *********/

/* Post-hook for selection changes. Typically overwritten in subclasses.
 */
- (void) afterSelectionChanged {
}

- (void) sendSelectionDidChangeNotification {
  debugLog(@"POSTING");
	[[NSNotificationCenter defaultCenter] postNotificationName:LLCollectionViewSelectionDidChangeNotification object:self];
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

NSString *LLCollectionViewSelectionDidChangeNotification = @"LLCollectionViewSelectionDidChangeNotification";