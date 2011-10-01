#import "SlideView.h"

#import <QuartzCore/CoreAnimation.h>
#import <QTKit/QTKit.h>

@implementation SlideView

@synthesize slide;

- (id) initWithSlide:(Slide*)newSlide {
  self = [super initWithFrame:NSMakeRect(0, 0, 0, 0)];
  if (self) {
    self.slide = newSlide;
    [self setLayer:[self rootLayer]];
    [self setWantsLayer:YES];
  }
  return self;
}

- (CALayer*) rootLayer {
  if (rootLayer) return rootLayer;
  rootLayer = [CALayer layer];
  rootLayer.layoutManager = [CAConstraintLayoutManager layoutManager];
  CGColorRef blackColor = CGColorCreateGenericRGB(0,0,0,1);
  rootLayer.backgroundColor = blackColor;
  CGColorRelease(blackColor);
  [rootLayer addSublayer:[self textLayer]];
  return rootLayer;
}

- (CATextLayer*) textLayer {
  if (textLayer) return textLayer;
  textLayer = [CATextLayer layer];
  textLayer.string = [self.slide content];
  //textLayer.alignmentMode = kCAAlignmentCenter;
  textLayer.wrapped = YES;
  //textLayer.truncationMode = kCATruncationMiddle;
  textLayer.fontSize = 10;
  CGColorRef whiteColor = CGColorCreateGenericRGB(1,1,1,1);
  textLayer.foregroundColor = whiteColor;
  CGColorRelease(whiteColor);
  CAConstraint *horizontalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX relativeTo:@"superlayer" attribute:kCAConstraintMidX];
  CAConstraint *verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY relativeTo:@"superlayer" attribute:kCAConstraintMidY]; 
  CAConstraint *heightConstraint = [CAConstraint constraintWithAttribute:kCAConstraintHeight relativeTo:@"superlayer" attribute:kCAConstraintHeight]; 
  CAConstraint *widthConstraint = [CAConstraint constraintWithAttribute:kCAConstraintWidth relativeTo:@"superlayer" attribute:kCAConstraintWidth]; 
  [textLayer setConstraints:[NSArray arrayWithObjects:heightConstraint, widthConstraint, verticalConstraint, horizontalConstraint, nil]];
  return textLayer;
}

@end