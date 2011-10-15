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

- (id) initWithSlide:(Slide*)newSlide andBoxing:(BOOL)newBoxing {
  return [self initWithSlide:newSlide andCollectionView:nil andBoxing:newBoxing];
}

- (id) initWithSlide:(Slide*)newSlide andCollectionView:(NSCollectionView*)newCollectionView {
  return [self initWithSlide:newSlide andCollectionView:newCollectionView andBoxing:YES];
}

- (id) initWithSlide:(Slide*)newSlide andCollectionView:(NSCollectionView*)newCollectionView andBoxing:(BOOL)newBoxing {
  self = [super initWithFrame:NSMakeRect(0, 0, 0, 0)];
  if (self) {
    self.slide = newSlide;
    self.isBoxed = newBoxing;
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
  [self sendWasClickedNotification:SlideWasSingleClickedNotification];
}

- (void) wasDoubleClicked {
  [self sendWasClickedNotification:SlideWasDoubleClickedNotification];
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
  self.backgroundLayer.bounds = CGRectMake(0, 0,  self.rootLayer.bounds.size.width * 0.95, self.rootLayer.bounds.size.height * 0.95);
}

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



-(void) toggleFullscreen {
  if ([self isInFullScreenMode]) {
    [self exitFullScreen];
    [NSCursor unhide];
  } else {
    [self goFullscreenOnScreen:[self.window screen]];
  }
}

- (void) exitFullScreen {
  [self exitFullScreenModeWithOptions:NULL];
  [self.window makeFirstResponder:self];
}

-(void) goFullscreenOnScreen:(NSScreen*)screen {
  NSNumber *presentationOptions = [NSNumber numberWithUnsignedInt:(NSApplicationPresentationAutoHideMenuBar|NSApplicationPresentationAutoHideDock|NSApplicationPresentationDisableProcessSwitching)];
  NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, presentationOptions, NSFullScreenModeApplicationPresentationOptions, nil];
  if (![self isInFullScreenMode]) {
    if (screen == [NSScreen mainScreen]) [NSCursor hide];
    [self enterFullScreenMode:screen withOptions:opts];
  } else {
    if (screen == [NSScreen mainScreen]) [NSCursor hide];
    [self exitFullScreenModeWithOptions:NULL];
    [self enterFullScreenMode:screen withOptions:opts];
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