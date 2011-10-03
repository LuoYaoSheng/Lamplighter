@class Slide;
@class SlideRootLayer;
@class SlideBackgroundLayer;
@class SlideTextLayer;

@interface SlideView : NSView {

  Slide *slide;
  
  SlideRootLayer *rootLayer;
  SlideBackgroundLayer *backgroundLayer;
  SlideTextLayer *textLayer;
  
}

@property (nonatomic, retain, readwrite) Slide *slide;

@property (nonatomic, retain, readonly) SlideRootLayer *rootLayer;
@property (nonatomic, retain, readonly) SlideBackgroundLayer *backgroundLayer;
@property (nonatomic, retain, readonly) SlideTextLayer *textLayer;

- (id) initWithSlide:(Slide*)newSlide;

@end
