#import "SlideBackgroundLayer.h"

@implementation SlideBackgroundLayer


+ (id) layer {
  SlideBackgroundLayer *newLayer = [super layer];
  if (newLayer) {
    [newLayer setupColors];
    [newLayer setupConstraints];
  }
  return newLayer;
}

- (void) setupColors {
  CGColorRef blackColor = CGColorCreateGenericRGB(0,0,0,1);
  self.backgroundColor = blackColor;
  CGColorRelease(blackColor);
}

- (void) setupConstraints {
  self.layoutManager = [CAConstraintLayoutManager layoutManager];
  CAConstraint *horizontalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX relativeTo:@"superlayer" attribute:kCAConstraintMidX];
  CAConstraint *verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY relativeTo:@"superlayer" attribute:kCAConstraintMidY]; 
  [self setConstraints:[NSArray arrayWithObjects:verticalConstraint, horizontalConstraint, nil]];
}


@end