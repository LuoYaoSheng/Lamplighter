@class Slide;
@class SlideRootLayer;
@class SlideBackgroundLayer;
@class SlideTextLayer;
@class SlideFootnotesLayer;

@interface SlideView : NSView {

  // Objects
  Slide *slide;
  NSCollectionView *collectionView;
  
  // Status trackers
  BOOL isSelected;
  BOOL isBoxed;
  
  // Layers
  SlideRootLayer *rootLayer;
  SlideBackgroundLayer *backgroundLayer;
  SlideTextLayer *textLayer;
  SlideFootnotesLayer *footnotesLayer;
  
}

/**************
 * PROPERTIES *
 **************/

// Objects
@property (nonatomic, readwrite) Slide *slide;
@property (nonatomic, readwrite) NSCollectionView *collectionView;

// Status trackers
@property (readwrite) BOOL isSelected;
@property (readwrite) BOOL isBoxed;

// Layers
@property (nonatomic, readonly) SlideRootLayer *rootLayer;
@property (nonatomic, readonly) SlideBackgroundLayer *backgroundLayer;
@property (nonatomic, readonly) SlideTextLayer *textLayer;
@property (nonatomic, readwrite) SlideFootnotesLayer *footnotesLayer;

/***********
 * METHODS *
 ***********/

// Initialization
- (id) initWithSlide:(Slide*)newSlide andPreviewMode:(BOOL)newPreviewMode;
- (id) initWithSlide:(Slide*)newSlide andCollectionView:(NSCollectionView*)newCollectionView;
- (id) initWithSlide:(Slide*)newSlide andCollectionView:(NSCollectionView*)newCollectionView andPreviewMode:(BOOL)newPreviewMode;
- (void) deactivateAnimations;

// Event tracking
- (void) wasSingleClicked;
- (void) wasDoubleClicked;
- (void) sendWasClickedNotification:(NSString*)notificationName;

// Selection Handling
- (void) setSelected:(BOOL)flag;

// Drawing
- (void) resizeLayers;

// Selection handling
- (void) updateSelected;

@end
