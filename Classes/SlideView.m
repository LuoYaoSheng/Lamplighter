#import "SlideView.h"

#import <QuartzCore/CoreAnimation.h>
#import <QTKit/QTKit.h>

@implementation SlideView

@synthesize content;

- (id) initWithContent:(NSString*)newContent {
  self = [super initWithFrame:NSMakeRect(0, 0, 0, 0)];
  if (self) {
    [self setContent:newContent];
    [self setLayer:[self rootLayer]];
    [self setWantsLayer:YES];

  }
  return self;
}

- (void) drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

- (CALayer*) rootLayer {
  if (rootLayer) return rootLayer;
  rootLayer = [CALayer layer];
  [rootLayer setLayoutManager:[CAConstraintLayoutManager layoutManager]];
  [rootLayer addSublayer:[self textLayer]];
  return rootLayer;
}

- (CATextLayer*) textLayer {
  if (textLayer) return textLayer;
  textLayer = [CATextLayer layer];
  textLayer.string = self.content;
  textLayer.alignmentMode = kCAAlignmentCenter;
  textLayer.fontSize = 10;
  CGColorRef whiteColor = CGColorCreateGenericRGB(1,1,1,1);
  textLayer.foregroundColor = whiteColor;
  CGColorRelease(whiteColor);
  CAConstraint *horizontalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX relativeTo:@"superlayer" attribute:kCAConstraintMidX];
  CAConstraint *verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY relativeTo:@"superlayer" attribute:kCAConstraintMidY]; 
  [textLayer setConstraints:[NSArray arrayWithObjects:verticalConstraint, horizontalConstraint, nil]];
  return textLayer;
}

@end