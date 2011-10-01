@class Slide;
@class CALayer;
@class CATextLayer;

@interface SlideView : NSView {

  Slide *slide;
  
  CALayer *rootLayer;
  CATextLayer *textLayer;
  
}

@property (nonatomic, retain, readwrite) Slide *slide;

@property (nonatomic, retain, readonly) CALayer *rootLayer;
@property (nonatomic, retain, readonly) CATextLayer *textLayer;

@end
