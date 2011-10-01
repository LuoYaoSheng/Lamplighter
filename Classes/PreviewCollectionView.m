#import "PreviewCollectionView.h"

#import "SlideView.h"

@implementation PreviewCollectionView

- (NSCollectionViewItem*) newItemForRepresentedObject:(id)object {
  
  [self setMaxItemSize:NSMakeSize(200, 150)];
  [self setMinItemSize:NSMakeSize(200, 150)];
  
  SlideView *slideView = [[SlideView alloc] initWithSlide:object];
  NSCollectionViewItem *item = [NSCollectionViewItem new];
  [item setView:slideView];
    
  return item;
}

@end