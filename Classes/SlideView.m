#import "SlideView.h"

#import <QuartzCore/CoreAnimation.h>
#import <QTKit/QTKit.h>
#import "ApplicationDelegate.h"
#import "LiveviewController.h"
#import "SlideRootLayer.h"
#import "SlideBackgroundLayer.h"
#import "SlideTextLayer.h"
#import "MainWindowController.h"
#import "EditSongWindowController.h"

@implementation SlideView

@synthesize slide, isSelected, collectionView;

/******************
 * INITIALIZATION *
 ******************/

- (id) initWithSlide:(Slide*)newSlide andCollectionView:(NSCollectionView*)newCollectionView {
  self = [super initWithFrame:NSMakeRect(0, 0, 0, 0)];
  if (self) {
    self.slide = newSlide;
    self.collectionView = newCollectionView;
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

/******************
 * EVENT TRACKING *
 ******************/

- (void) mouseDown:(NSEvent*)event {
  switch ([event clickCount]) {
    case 1: [self singleClicked]; break;
    case 2: [self doubleClicked]; break;
  }
}

- (void) singleClicked {
  [[NSNotificationCenter defaultCenter] postNotificationName:SlideWasSingleClickedNotification object:self];

  debugLog(@"my pos: %i", [[self.slide position] integerValue]);
  debugLog(@"my view: %@", self.collectionView);
  [[[NSApp mainWindowController] liveviewController] setPresentation:[self.slide presentation] andIndex:[[self.slide position] integerValue]];
}

- (void) doubleClicked {
  [[NSNotificationCenter defaultCenter] postNotificationName:SlideWasDoubleClickedNotification object:self];
}

/**********************
 * SELECTION HANDLING *
 **********************/

- (void) setSelected:(BOOL)flag {
  self.isSelected = flag;
}

/***********
 * DRAWING *
 ***********/

- (void) viewWillDraw {
  [self resizeLayers];
  [self updateSelected];
}

- (void) resizeLayers {
  [self deactivateAnimations];
  self.backgroundLayer.bounds = CGRectMake(0, 0,  self.rootLayer.bounds.size.width * 0.95, self.rootLayer.bounds.size.height * 0.95);
}

- (void) updateSelected {
  if (self.isSelected) {
    CGColorRef selectedColor = CGColorCreateGenericRGB(1,1,0,0.5);
    self.rootLayer.backgroundColor = selectedColor;
    CGColorRelease(selectedColor);
  } else {
    CGColorRef transparentColor = CGColorCreateGenericRGB(0,0,0,0);
    self.rootLayer.backgroundColor = transparentColor;
    CGColorRelease(transparentColor);
  }
}

/******************
 * GETTER METHODS *
 ******************/

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