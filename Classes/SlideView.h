@class CATextLayer;

@interface SlideView : NSView {

  NSString *content;
  
  CALayer *rootLayer;
  CATextLayer *textLayer;
  
}

@property (nonatomic, retain, readwrite) NSString *content;

@property (nonatomic, retain, readonly) CALayer *rootLayer;
@property (nonatomic, retain, readonly) CATextLayer *textLayer;

@end
