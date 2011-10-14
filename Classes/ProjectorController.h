@class ProjectorWindowController;

#import "Slide.h"

@interface ProjectorController : NSObject {

  // Window Controllers
  ProjectorWindowController *projectorWindowController;

  // Blank Slide
  Slide *blankSlide;

}

// Window Controllers
@property (nonatomic, retain, readonly) ProjectorWindowController *projectorWindowController;

@property (nonatomic, retain, readonly) Slide *blankSlide;

- (IBAction) toggleLive;
- (BOOL) isLive;
- (void) goLive;
- (void) leaveLive;
- (void) setSlide:(Slide*)newSlide;

@end