#import "SlideView.h"

#import <QuartzCore/CoreAnimation.h>
#import <QTKit/QTKit.h>
#import "SlideRootLayer.h"
#import "SlideBackgroundLayer.h"
#import "SlideTextLayer.h"

@implementation SlideView

@synthesize slide;

- (id) initWithSlide:(Slide*)newSlide {
  self = [super initWithFrame:NSMakeRect(0, 0, 0, 0)];
  if (self) {
    self.slide = newSlide;
    [self setLayer:[self rootLayer]];
    [self setWantsLayer:YES];
    [[self rootLayer] addSublayer:[self backgroundLayer]];
    [[self backgroundLayer] addSublayer:[self textLayer]];
  }
  return self;
}

- (void) viewWillDraw {
  [self resizeLayers];
}

- (void) resizeLayers {
  self.backgroundLayer.bounds = CGRectMake(0, 0,  self.rootLayer.bounds.size.width * 0.9, self.rootLayer.bounds.size.height * 0.9);
}

- (SlideRootLayer*) rootLayer {
  if (rootLayer) return rootLayer;
  rootLayer = [SlideRootLayer layer];
  return rootLayer;
}

- (SlideBackgroundLayer*) backgroundLayer {
  if (backgroundLayer) return backgroundLayer;
  backgroundLayer = [SlideBackgroundLayer layer];
  return backgroundLayer;
}

- (SlideTextLayer*) textLayer {
  if (textLayer) return textLayer;
  textLayer = [SlideTextLayer layerForSlide:self.slide];
  return textLayer;
}

@end