@class ApplicationDelegate;
@class PreviewController;
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


// Application Delegate Outlet
@property (nonatomic, retain, readonly) ApplicationDelegate *applicationDelegate;

// Preview Controller
@property (nonatomic, retain, readonly) PreviewController *previewController;

// Playlist
@property (nonatomic, retain, readonly) NSTableColumn *playlistTableColumn;
@property (nonatomic, retain, readonly) NSTableView *playlistTableView;
@property (nonatomic, retain, readonly) PlaylistTableDataSource *playlistTableDataSource;

// Collection View Items
@property (nonatomic, retain, readonly) NSCollectionView *previewCollectionView;
@property (nonatomic, retain, readonly) NSCollectionView *liveviewCollectionView;

// Drawer
@property (nonatomic, retain, readonly) SongsDrawer *songsDrawer;
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;

// Song creation
@property (nonatomic, retain, readonly) NewSongWindowController *newSongWindowController;
@property (nonatomic, retain, readonly) EditSongWindowController *editSongWindowController;

// Playlist
- (void) setupPlaylistTable;

// Collection Views
- (void) setupPreviewCollectionView;
- (void) setupLiveviewCollectionView;

// Drawer
- (IBAction) toggleSongsDrawer:sender;
- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;

@end