#import <QuartzCore/CoreAnimation.h>
#import <QTKit/QTKit.h>

#import "Slide.h"

@interface SlideTextLayer : CATextLayer {

}

+ (id) layerForSlide:(Slide*)newSlide;

- (void) setupBindingForSlide:(Slide*)newSlide;
- (void) setupConstraints;
- (void) setupFont;

- (CGFloat) calcSize:(CGRect)rect;

@end