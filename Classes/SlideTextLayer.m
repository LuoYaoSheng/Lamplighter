#import "SlideTextLayer.h"

#import "Slide.h"

@implementation SlideTextLayer

+ (id) layerForSlide:(Slide*)newSlide {
  SlideTextLayer *newLayer = [SlideTextLayer layer];
  if (newLayer) {
    [newLayer setupBindingForSlide:newSlide];
    //[newLayer setupColors]; 
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
  self.font = @"Helvetica Neue";
  CGColorRef whiteColor = CGColorCreateGenericRGB(1,1,1,1);
  self.foregroundColor = whiteColor;
  CGColorRelease(whiteColor);
}

- (void) setupSize {
  [self increaseToMaxSize];
  
}

- (void) increaseToMaxSize {
 // debugLog(@"me    %f", self.bounds.size.width);
 // debugLog(@"super %f", self.superlayer.bounds.size.width);
 // debugLog(@"smaller? %i", [self isSmaller]);
  
  int i = 0;
  /*while ([self isSmaller] && i < 100) {
    self.fontSize++;
    i++;
  }*/
  debugLog(@"superlayer %@", self.superlayer);

  CGRect rect = CGRectMake(0.0, 0.0, self.superlayer.bounds.size.width, self.superlayer.bounds.size.height);
  CGFloat size = [self calcSize:rect];

  self.fontSize = size;
}

- (CGFloat) calcSize:(CGRect)rect {
  float targetWidth = rect.size.width - 0;
  float targetHeight = rect.size.height - 0;
  
  int minFontSize = targetWidth / 25;
  int maxFontSize = targetWidth / 15;
  // the strategy is to start with a small font size and go larger until I'm larger than one of the target sizes
  CGFloat i;
  for (i=minFontSize; i<maxFontSize; i++) {
    NSDictionary* attrs = [[NSDictionary alloc] initWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica Neue" size:i], NSFontAttributeName, nil];
    NSSize strSize = [self.string sizeWithAttributes:attrs];
    [attrs release];
    if (strSize.width > targetWidth || strSize.height > targetHeight) break;
  }
  return i;
}

- (BOOL) isSmaller {
  if ((int)(self.superlayer.bounds.size.width * 1000) == 0) return 0;
  return self.bounds.size.width < self.superlayer.bounds.size.width;
}


@end