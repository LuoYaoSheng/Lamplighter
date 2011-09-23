@class ProjectorWindowController;

@interface ProjectorController : NSObject <NSTableViewDelegate> {

  // Window Controllers
  ProjectorWindowController *projectorWindowController;

}

@property (nonatomic, retain, readonly) ProjectorWindowController *projectorWindowController;

- (NSTableView*) songsTableView;
- (NSTableView*) playlistTableView;

@end