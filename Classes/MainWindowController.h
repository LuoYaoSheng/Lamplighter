@class ApplicationDelegate;
@class SongsDrawerViewController;
@class SongsDrawer;
@class NewSongWindowController;
@class PlaylistTableDataSource;
@class ProjectorController;

@interface MainWindowController : NSWindowController {
  
  // Application Delegate Outlet
  IBOutlet ApplicationDelegate *applicationDelegate;
  
  // Playlist
  IBOutlet NSTableColumn *playlistTableColumn;
  IBOutlet NSTableView *playlistTableView;
  PlaylistTableDataSource *playlistTableDataSource;
  
  // Drawer
  SongsDrawer *songsDrawer;
  SongsDrawerViewController *songsDrawerViewController;

  // Song creation
  NewSongWindowController *newSongWindowController;

  // Projector
  ProjectorController *projectorController;
}


// Application Delegate Outlet
@property (nonatomic, retain, readonly) ApplicationDelegate *applicationDelegate;

// Playlist
@property (nonatomic, retain, readonly) NSTableColumn *playlistTableColumn;
@property (nonatomic, retain, readonly) NSTableView *playlistTableView;
@property (nonatomic, retain, readonly) PlaylistTableDataSource *playlistTableDataSource;

// Drawer
@property (nonatomic, retain, readonly) SongsDrawer *songsDrawer;
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;

// Song creation
@property (nonatomic, retain, readonly) NewSongWindowController *newSongWindowController;

// Projector
@property (nonatomic, retain, readonly) ProjectorController *projectorController;

// Playlist
- (void) setupPlaylistTable;

// Drawer
- (IBAction) toggleSongsDrawer:sender;
- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;

@end