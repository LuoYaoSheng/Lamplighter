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

@synthesize slide, isSelected, isBoxed, collectionView;

/******************
 * INITIALIZATION *
 ******************/

- (id) initWithSlide:(Slide*)newSlide andPreviewMode:(BOOL)newPreviewMode {
  return [self initWithSlide:newSlide andCollectionView:nil andPreviewMode:newPreviewMode];
}

- (id) initWithSlide:(Slide*)newSlide andCollectionView:(NSCollectionView*)newCollectionView {
  return [self initWithSlide:newSlide andCollectionView:newCollectionView andPreviewMode:YES];
}

- (id) initWithSlide:(Slide*)newSlide andCollectionView:(NSCollectionView*)newCollectionView andPreviewMode:(BOOL)newPreviewMode {
  self = [super initWithFrame:NSMakeRect(0, 0, 0, 0)];
  if (self) {
    self.slide = newSlide;
    self.isBoxed = newPreviewMode;
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
  [super mouseDown:event];
  switch ([event clickCount]) {
    case 1: [self wasSingleClicked]; break;
    case 2: [self wasDoubleClicked]; break;
  }
}

- (void) wasSingleClicked {
  [self sendWasClickedNotification:SlideViewWasSingleClickedNotification];
}

- (void) wasDoubleClicked {
  [self sendWasClickedNotification:SlideViewWasDoubleClickedNotification];
}

- (void) sendWasClickedNotification:(NSString*)notificationName {
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
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
  [self.textLayer setupSize];
}

- (void) resizeLayers {
  [self deactivateAnimations];
  CGFloat horizontalMargin = self.rootLayer.bounds.size.width / 20;
  CGFloat verticalMargin = self.rootLayer.bounds.size.height / 10;
  CGFloat margin = (horizontalMargin + verticalMargin) / 2;
  //if (verticalMargin > horizontalMargin) margin = verticalMargin;
  self.backgroundLayer.bounds = CGRectMake(0, 0,  self.rootLayer.bounds.size.width - margin, self.rootLayer.bounds.size.height - margin);
}

/**********************
 * SELECTION HANDLING *
 **********************/

- (void) updateSelected {
  CGColorRef rootColor;
  if (self.isBoxed) {
    if (self.isSelected) {
      rootColor = CGColorCreateGenericRGB(1,1,0,0.5); // Green
    } else {
      rootColor = CGColorCreateGenericRGB(0,0,0,0); // Transparent
    }
  } else {
    rootColor = CGColorCreateGenericRGB(0,0,0,1); // Black
  }
  self.rootLayer.backgroundColor = rootColor;
  CGColorRelease(rootColor);
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