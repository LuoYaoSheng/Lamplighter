#import <QuartzCore/QuartzCore.h>

#import "Slide.h"

@interface SlideFootnotesLayer : CATextLayer

// Initialization
+ (id) layerForSlide:(Slide*)newSlide;

- (void) setupSize;

@end
