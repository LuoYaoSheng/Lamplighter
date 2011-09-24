@class ApplicationDelegate;
@class PreviewController;
@class SongsDrawerViewController;
@class SongsDrawer;
@class NewSongWindowController;
@class PlaylistTableDataSource;

@interface MainWindowController : NSWindowController {
  
  // Application Delegate Outlet
  IBOutlet ApplicationDelegate *applicationDelegate;
  
  // Preview Controller
  PreviewController *previewController;
  
  // Playlist
  IBOutlet NSTableColumn *playlistTableColumn;
  IBOutlet NSTableView *playlistTableView;
  PlaylistTableDataSource *playlistTableDataSource;
  
  // Drawer
  SongsDrawer *songsDrawer;
  SongsDrawerViewController *songsDrawerViewController;

  // Song creation
  NewSongWindowController *newSongWindowController;
}


// Application Delegate Outlet
@property (nonatomic, retain, readonly) ApplicationDelegate *applicationDelegate;

// Preview Controller
@property (nonatomic, retain, readonly) PreviewController *previewController;

// Playlist
@property (nonatomic, retain, readonly) NSTableColumn *playlistTableColumn;
@property (nonatomic, retain, readonly) NSTableView *playlistTableView;
@property (nonatomic, retain, readonly) PlaylistTableDataSource *playlistTableDataSource;

// Drawer
@property (nonatomic, retain, readonly) SongsDrawer *songsDrawer;
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;

// Song creation
@property (nonatomic, retain, readonly) NewSongWindowController *newSongWindowController;

// Playlist
- (void) setupPlaylistTable;

// Drawer
- (IBAction) toggleSongsDrawer:sender;
- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;

@end