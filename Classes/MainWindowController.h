@class ApplicationDelegate;
@class PreviewController;
@class LiveviewController;
@class SongsDrawerViewController;
@class SongsDrawer;
@class NewSongWindowController;
@class EditSongWindowController;
@class PlaylistTableDataSource;

@interface MainWindowController : NSWindowController {
  
  // Application Delegate Outlet
  IBOutlet ApplicationDelegate *applicationDelegate;
  
  // Preview Controller
  PreviewController *previewController;
  LiveviewController *liveviewController;
  
  // Playlist
  IBOutlet NSTableColumn *playlistTableColumn;
  IBOutlet NSTableView *playlistTableView;
  PlaylistTableDataSource *playlistTableDataSource;

  // Collection Views
  IBOutlet NSCollectionView *previewCollectionView;
  IBOutlet NSCollectionView *liveviewCollectionView;
  
  // Drawer
  SongsDrawer *songsDrawer;
  SongsDrawerViewController *songsDrawerViewController;

  // Song creation
  NewSongWindowController *newSongWindowController;
  EditSongWindowController *editSongWindowController;
}

/**************
 * PROPERTIES *
 **************/

// Application Delegate Outlet
@property (nonatomic, retain, readonly) ApplicationDelegate *applicationDelegate;

// Preview Controller
@property (nonatomic, retain, readonly) PreviewController *previewController;
@property (nonatomic, retain, readonly) LiveviewController *liveviewController;

// Playlist
@property (nonatomic, retain, readonly) NSTableColumn *playlistTableColumn;
@property (nonatomic, retain, readonly) NSTableView *playlistTableView;
@property (nonatomic, retain, readonly) PlaylistTableDataSource *playlistTableDataSource;

// Collection Views
@property (nonatomic, retain, readonly) NSCollectionView *previewCollectionView;
@property (nonatomic, retain, readonly) NSCollectionView *liveviewCollectionView;

// Drawer
@property (nonatomic, retain, readonly) SongsDrawer *songsDrawer;
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;

// Song creation
@property (nonatomic, retain, readonly) NewSongWindowController *newSongWindowController;
@property (nonatomic, retain, readonly) EditSongWindowController *editSongWindowController;

/***********
 * METHODS *
 ***********/

// Playlist
- (void) setupPlaylistTable;

// Drawer
- (IBAction) toggleSongsDrawer:sender;
- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;

// Projector
- (IBAction) toggleLive:sender;

@end