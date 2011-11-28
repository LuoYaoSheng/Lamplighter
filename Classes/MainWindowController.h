#import <Quartz/Quartz.h>

@class ApplicationDelegate;
@class PreviewController;
@class LiveviewController;
@class SongsDrawerViewController;
@class PDFsDrawerViewController;
@class NewSongWindowController;
@class EditSongWindowController;
@class PlaylistTableDataSource;
@class BaseCollectionView;
@class PreviewPDFThumbnailView;

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

  // Collection/Thumbnail Views
  IBOutlet PDFView *previewPDFView;
  IBOutlet PreviewPDFThumbnailView *previewPDFThumbnailView;
  IBOutlet BaseCollectionView *previewCollectionView;
  IBOutlet BaseCollectionView *liveviewCollectionView;
  
  // Drawer
  NSDrawer *songsDrawer;
  NSDrawer *pdfsDrawer;
  SongsDrawerViewController *songsDrawerViewController;
  PDFsDrawerViewController *pdfsDrawerViewController;

  // Song creation
  NewSongWindowController *newSongWindowController;
  EditSongWindowController *editSongWindowController;

  // Periphals
  NSWindowController *progressWindowController;

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

// Collection/Thumbnail Views
@property (nonatomic, retain, readwrite) PDFView *previewPDFView;
@property (nonatomic, retain, readonly) PreviewPDFThumbnailView *previewPDFThumbnailView;
@property (nonatomic, retain, readonly) BaseCollectionView *previewCollectionView;
@property (nonatomic, retain, readonly) BaseCollectionView *liveviewCollectionView;

// Drawer
@property (nonatomic, retain, readonly) NSDrawer *songsDrawer;
@property (nonatomic, retain, readonly) NSDrawer *pdfsDrawer;
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;
@property (nonatomic, retain, readonly) PDFsDrawerViewController *pdfsDrawerViewController;

// Song creation
@property (nonatomic, retain, readonly) NewSongWindowController *newSongWindowController;
@property (nonatomic, retain, readonly) EditSongWindowController *editSongWindowController;

// Periphals
@property (nonatomic, retain, readonly) NSWindowController *progressWindowController;

/***********
 * METHODS *
 ***********/

// Initialization
- (void) setupObservers;

// Playlist
- (void) setupPlaylistTable;

// Drawer
- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;
- (BOOL) isDrawerOpen;

// GUI Items
- (void) setupMenuLocalization;
- (void) localizeMenu:(NSMenu*)theMenu;
- (void) updateToolbarItem:(NSToolbarItem*)item;
- (void) updateMenuItem:(NSMenuItem*)item;

// Menu/Toolbar Actions
- (IBAction) togglePDFsDrawerAction:sender;
- (IBAction) toggleSongsDrawerAction:sender;
- (IBAction) toggleLiveAction:sender;
- (IBAction) projectorGoBlankAction:sender;

@end