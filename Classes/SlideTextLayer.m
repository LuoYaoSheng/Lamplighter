#import "SlideTextLayer.h"

#import "Slide.h"

@implementation SlideTextLayer

+ (id) layerForSlide:(Slide*)newSlide {
  SlideTextLayer *newLayer = [SlideTextLayer layer];
  if (newLayer) {
    [newLayer setupBindingForSlide:newSlide];
    [newLayer setupColors]; 
    [newLayer setupConstraints]; 
    [newLayer setupFont];
  }
  return newLayer;
}

- (void) setupColors {
  CGColorRef blackColor = CGColorCreateGenericRGB(0,1,0,1);
  self.backgroundColor = blackColor;
  CGColorRelease(blackColor);
}


- (void) setupBindingForSlide:(Slide*)newSlide {
  [self bind:@"string" toObject:newSlide withKeyPath:@"content" options:nil];
}

- (void) setupConstraints {
  CAConstraint *horizontalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX relativeTo:@"superlayer" attribute:kCAConstraintMidX];
  CAConstraint *verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY relativeTo:@"superlayer" attribute:kCAConstraintMidY]; 
  [self setConstraints:[NSArray arrayWithObjects:verticalConstraint, horizontalConstraint, nil]];
}

- (void) setupFont {
  self.alignmentMode = kCAAlignmentCenter;
  //self.truncationMode = kCATruncationEnd;
  self.fontSize = 15;
  CGColorRef whiteColor = CGColorCreateGenericRGB(1,1,1,1);
  self.foregroundColor = whiteColor;
  CGColorRelease(whiteColor);
}

@end