#import "BaseCollectionView.h"

#import "ApplicationDelegate.h"
#import "SlideView.h"
#import "Presentation.h"
#import "ProjectorController.h"

@implementation BaseCollectionView

- (NSCollectionViewItem*) newItemForRepresentedObject:(id)object {
  
  [self setMaxItemSize:NSMakeSize(200, 150)];
  [self setMinItemSize:NSMakeSize(200, 150)];
  
  SlideView *slideView = [[SlideView alloc] initWithSlide:object];
  NSCollectionViewItem *item = [NSCollectionViewItem new];
  [item setView:slideView];
    
  return item;
}

- (void) setContentAndUpdateSelectionFor:(Presentation*)presentation {
  if (!presentation) return;
  [self setContent:[presentation sortedSlides]];
  [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:0]];
}  

- (void) setSelectionIndexes:(NSIndexSet*)indexes {
  [super setSelectionIndexes:indexes];
  [self afterSetSelectionIndexes:indexes];
}

- (void) afterSetSelectionIndexes:(NSIndexSet*)indexes {
  Slide* selectedSlide = [[self content] objectAtIndex:[indexes firstIndex]];
  [[NSApp projectorController] setSlide:selectedSlide];
}

@end