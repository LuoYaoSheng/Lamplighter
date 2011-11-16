@class ProjectorWindowController;

#import "Slide.h"

@interface ProjectorController : NSObject {

  // Window Controllers
  ProjectorWindowController *projectorWindowController;

}

/**************
 * PROPERTIES *
 **************/

// Window Controllers
@property (nonatomic, retain, readonly) ProjectorWindowController *projectorWindowController;

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