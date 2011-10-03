#import "SlideRootLayer.h"

@implementation SlideRootLayer

+ (id) layer {
  SlideRootLayer *newLayer = [super layer];
  if (newLayer) {
    [newLayer setupConstraints];
  }
  return newLayer;
}

- (void) setupConstraints {
  self.layoutManager = [CAConstraintLayoutManager layoutManager];
}

@end