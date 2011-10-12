@class Slide;
@class SlideRootLayer;
@class SlideBackgroundLayer;
@class SlideTextLayer;

@interface SlideView : NSView {

  // Objects
  Slide *slide;
  NSCollectionView *collectionView;
  
  // Status trackers
  BOOL isSelected;
  
  // Layers
  SlideRootLayer *rootLayer;
  SlideBackgroundLayer *backgroundLayer;
  SlideTextLayer *textLayer;
  
}

/**************
 * PROPERTIES *
 **************/

// Objects
@property (nonatomic, retain, readwrite) Slide *slide;
@property (nonatomic, retain, readwrite) NSCollectionView *collectionView;

// Status trackers
@property (readwrite) BOOL isSelected;

// Layers
@property (nonatomic, retain, readonly) SlideRootLayer *rootLayer;
@property (nonatomic, retain, readonly) SlideBackgroundLayer *backgroundLayer;
@property (nonatomic, retain, readonly) SlideTextLayer *textLayer;

/***********
 * METHODS *
 ***********/

// Initialization
- (id) initWithSlide:(Slide*)newSlide;
- (void) deactivateAnimations;

// Event tracking
- (void) singleClicked;
- (void) doubleClicked;

// Selection Handling
- (void) setSelected:(BOOL)flag;

// Drawing
- (void) resizeLayers;
- (void) updateSelected;

@end
