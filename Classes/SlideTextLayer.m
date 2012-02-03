#import "SlideTextLayer.h"

#import "Slide.h"

@implementation SlideTextLayer

/******************
 * INITIALIZATION *
 ******************/

+ (id) layerForSlide:(Slide*)newSlide {
  SlideTextLayer *newLayer = [SlideTextLayer layer];
  if (newLayer) {
    [newLayer setupBindingForSlide:newSlide];
    [newLayer setupConstraints]; 
    [newLayer setupFontAlignment];
    [newLayer hideFont];
  }
  return newLayer;
}

- (void) setupBindingForSlide:(Slide*)newSlide {
  [self bind:@"string" toObject:newSlide withKeyPath:@"content" options:nil];
}

- (void) setupConstraints {
  CAConstraint *horizontalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX relativeTo:@"superlayer" attribute:kCAConstraintMidX];
  CAConstraint *verticalConstraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY relativeTo:@"superlayer" attribute:kCAConstraintMidY]; 
  [self setConstraints:[NSArray arrayWithObjects:verticalConstraint, horizontalConstraint, nil]];
}

- (void) setupFontAlignment {
  self.alignmentMode = kCAAlignmentCenter;
}

- (void) hideFont {
  CGColorRef blackColor = CGColorCreateGenericRGB(0,0,0,1);
  self.foregroundColor = blackColor;
  CGColorRelease(blackColor);
}

- (void) showFont {
  CGColorRef whiteColor = CGColorCreateGenericRGB(1,1,1,1);
  self.foregroundColor = whiteColor;
  CGColorRelease(whiteColor);
}

/*****************
 * FONT RESIZING *
 *****************/

- (void) setupSize {
  [self increaseToMaxSize];
  // Show the text only after resize
  [self showFont];
}

- (void) increaseToMaxSize {
  self.fontSize = [self maxTextSizeForRectangle:CGSizeMake(self.superlayer.bounds.size.width, self.superlayer.bounds.size.height)];
}

- (CGFloat) maxTextSizeForRectangle:(NSSize)size {
  float targetWidth = size.width - 0;
  float targetHeight = size.height - 0;
  int minFontSize = targetWidth / 25;
  int maxFontSize = targetWidth / 15;
  CGFloat i;
  CGFloat step = 0.5;
  for (i=minFontSize; i<maxFontSize; i = i + step) {
    NSDictionary* attrs = [[NSDictionary alloc] initWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica Neue" size:i], NSFontAttributeName, nil];
    NSSize strSize = [self.string sizeWithAttributes:attrs];
    if (strSize.width > targetWidth || strSize.height > targetHeight) break;
  }
  return i - step;
}

- (BOOL) isSmaller {
  if ((int)(self.superlayer.bounds.size.width * 1000) == 0) return 0;
  return self.bounds.size.width < self.superlayer.bounds.size.width;
}

@end