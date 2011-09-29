#import "PreviewCollectionView.h"

#import "SlideView.h"
#import <QuartzCore/CoreAnimation.h>
#import <QTKit/QTKit.h>

@implementation PreviewCollectionView

- (NSCollectionViewItem*) newItemForRepresentedObject:(id)object {
  
  CATextLayer *textLayer = [CATextLayer layer];
  textLayer.backgroundColor = CGColorCreateGenericRGB(0,1,0,1);
  textLayer.string = [object content];
  textLayer.alignmentMode = kCAAlignmentCenter;
  textLayer.fontSize = 10;
  //textLayer.foregroundColor = whiteColor;

  CAConstraint *horizontalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX relativeTo:@"superlayer" attribute:kCAConstraintMidX];
  CAConstraint *verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY relativeTo:@"superlayer" attribute:kCAConstraintMidY]; 
  [textLayer setConstraints:[NSArray arrayWithObjects:verticalConstraint, horizontalConstraint, nil]];

  CALayer *rootLayer = [CALayer layer];
  [rootLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
  [rootLayer addSublayer:textLayer];
  
  SlideView *slideView = [[SlideView alloc] initWithFrame:NSMakeRect(0, 0, 200, 150)] ;
  
  //NSView *slideView = [[NSApp mainWindowController] previewSlideView];
  [slideView setLayer:rootLayer];
	[slideView setWantsLayer:YES];
  
  NSCollectionViewItem *item = [NSCollectionViewItem new];
  [item setView:slideView];
    
  return item;
}

@end
