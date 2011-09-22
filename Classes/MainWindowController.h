@class ApplicationDelegate;
@class SongsDrawerViewController;
@class SongsDrawer;
@class NewSongWindowController;
@class PlaylistTableDataSource;

@interface MainWindowController : NSWindowController {
  
  IBOutlet ApplicationDelegate *applicationDelegate;

  SongsDrawerViewController *songsDrawerViewController;
  SongsDrawer *songsDrawer;
  NewSongWindowController *newSongWindowController;

  PlaylistTableDataSource *playlistTableDataSource;

  IBOutlet NSTableColumn *playlistTableColumn;
  IBOutlet NSTableView *playlistTableView;

  IBOutlet NSMenuItem *toggleSongsMenuItem;
}


@property (nonatomic, retain, readonly) ApplicationDelegate *applicationDelegate;

// Drawer
@property (nonatomic, retain, readonly) SongsDrawer *songsDrawer;

// View Controllers
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;
@property (nonatomic, retain, readonly) NewSongWindowController *newSongWindowController;

@property (nonatomic, retain, readonly) PlaylistTableDataSource *playlistTableDataSource;

@property (nonatomic, retain, readonly) NSTableColumn *playlistTableColumn;
@property (nonatomic, retain, readonly) NSTableView *playlistTableView;

- (void) setupPlaylistTable;

// Handling the Drawer
- (IBAction) toggleSongsDrawer:(id)sender;
- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;

// New Song

@end
