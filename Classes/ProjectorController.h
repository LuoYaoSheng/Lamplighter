@class ProjectorWindowController;

@interface ProjectorController : NSObject {

  // States
  BOOL isLive;
  
  // Window Controllers
  ProjectorWindowController *projectorWindowController;

}

// States
@property (readwrite) BOOL isLive;

// Window Controllers
@property (nonatomic, retain, readonly) ProjectorWindowController *projectorWindowController;

- (IBAction) toggleLive;

- (IBAction) goLive;
- (IBAction) leaveLive;

- (void) projectorWindowWillClose;
- (void) afterLeaveLive;

@end