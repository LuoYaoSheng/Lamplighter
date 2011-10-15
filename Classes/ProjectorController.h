@class ProjectorWindowController;

#import "Slide.h"

@interface ProjectorController : NSObject {

  // Window Controllers
  ProjectorWindowController *projectorWindowController;

  // Blank Slide
  Slide *blankSlide;

}

/**************
 * PROPERTIES *
 **************/

// Window Controllers
@property (nonatomic, retain, readonly) ProjectorWindowController *projectorWindowController;

@property (nonatomic, retain, readonly) Slide *blankSlide;

/***********
 * METHODS *
 ***********/

// Instance Methods
- (NSSize) sizeOfProjectorScreen;
- (BOOL) isBlank;
- (void) goBlank;
- (void) toggleLive;
- (BOOL) isLive;
- (void) goLive;
- (void) leaveLive;
- (void) setSlide:(Slide*)newSlide;

@end