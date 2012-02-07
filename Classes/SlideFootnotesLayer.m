#import "SlideFootnotesLayer.h"

#import "Slide.h"


@implementation SlideFootnotesLayer

+ (id) layerForSlide:(Slide*)newSlide {
  SlideFootnotesLayer *newLayer = [SlideFootnotesLayer layer];
  if (newLayer) {
    [newLayer setupBindingForSlide:newSlide];
    [newLayer setupConstraints]; 
    [newLayer hideFont];
  }
  return newLayer;
}

- (void) setupConstraints {
  CAConstraint *horizontalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMinX relativeTo:@"superlayer" attribute:kCAConstraintMinX];
  CAConstraint *verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMinY relativeTo:@"superlayer" attribute:kCAConstraintMinY]; 
  [self setConstraints:[NSArray arrayWithObjects:verticalConstraint, horizontalConstraint, nil]];
}

- (void) setupBindingForSlide:(Slide*)newSlide {
  [self bind:@"string" toObject:newSlide withKeyPath:@"presentation.footnote" options:nil];
}

- (void) setupSize {
  self.fontSize = self.superlayer.bounds.size.height / 30;
  [self showFont];
}

- (void) hideFont {
  CGColorRef transparentColor = CGColorCreateGenericRGB(0,0,0,0);
  self.foregroundColor = transparentColor;
  CGColorRelease(transparentColor);
}

- (void) showFont {
  CGColorRef halfTransparentColor = CGColorCreateGenericRGB(1,1,1,0.5);
  self.foregroundColor = halfTransparentColor;
  CGColorRelease(halfTransparentColor);
}

@end
