#import "SlideCollectionViewItem.h"

#import "SlideView.h"

@implementation SlideCollectionViewItem

/************************
 * NSCollectionViewItem *
 ************************/

-(void) setSelected:(BOOL)flag {
  [super setSelected:flag];
  [(SlideView*)[self view] setSelected:flag];
  [[self view] setNeedsDisplay:YES];
}

@end