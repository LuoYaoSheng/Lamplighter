@class ProjectorWindowController;

#import "Slide.h"

@interface ProjectorController : NSObject {

  // Window Controllers
  ProjectorWindowController *projectorWindowController;

}

// Window Controllers
@property (nonatomic, retain, readonly) ProjectorWindowController *projectorWindowController;

- (IBAction) toggleLive;
- (BOOL) isLive;
- (void) goLive;
- (void) leaveLive;
- (void) showSlide:(Slide*)newSlide;

@end