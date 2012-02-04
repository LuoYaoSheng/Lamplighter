#import <QuartzCore/CoreAnimation.h>
#import <QTKit/QTKit.h>

#import "Slide.h"

@interface SlideTextLayer : CATextLayer {

}

// Initialization
+ (id) layerForSlide:(Slide*)newSlide;

- (void) setupBindingForSlide:(Slide*)newSlide;
- (void) setupConstraints;

// Font resizing
- (void) setupSize;
- (void) increaseToMaxSize;
- (CGFloat) maxTextSizeForRectangle:(NSSize)size;

@end