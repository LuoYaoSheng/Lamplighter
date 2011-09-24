@class ProjectorWindowController;

@interface ProjectorController : NSObject {

  // Window Controllers
  ProjectorWindowController *projectorWindowController;

}

@property (nonatomic, retain, readonly) ProjectorWindowController *projectorWindowController;

- (NSTableView*) songsTableView;
- (NSTableView*) playlistTableView;

@end