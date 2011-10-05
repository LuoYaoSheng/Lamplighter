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
    [self deactivateAnimations];
    [self setLayer:[self rootLayer]];
    [self setWantsLayer:YES];
    [[self rootLayer] addSublayer:[self backgroundLayer]];
    [[self backgroundLayer] addSublayer:[self textLayer]];
  }
  return self;
}

/* By default, Core Animation animates the changing of size, text, etc. of CALayers (and its decendants).
 * With the following command we can disable that. So all changes take immediate effect.
 */
 - (void) deactivateAnimations {
  [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
}

- (void) viewWillDraw {
  [self resizeLayers];
}

- (void) resizeLayers {
  [self deactivateAnimations];
  self.backgroundLayer.bounds = CGRectMake(0, 0,  self.rootLayer.bounds.size.width * 0.95, self.rootLayer.bounds.size.height * 0.95);
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