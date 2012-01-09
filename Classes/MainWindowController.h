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
@class BasePDFThumbnailView;
@class ProgressWindowController;

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
  PDFView *previewPDFView;
  IBOutlet BasePDFThumbnailView *previewPDFThumbnailView;
  IBOutlet BasePDFThumbnailView *liveviewPDFThumbnailView;
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
  ProgressWindowController *progressWindowController;

}

/**************
 * PROPERTIES *
 **************/

// Application Delegate Outlet
@property (nonatomic, readonly) ApplicationDelegate *applicationDelegate;

// Preview Controller
@property (nonatomic, readonly) PreviewController *previewController;
@property (nonatomic, readonly) LiveviewController *liveviewController;

// Playlist
@property (nonatomic, readonly) NSTableColumn *playlistTableColumn;
@property (nonatomic, readonly) NSTableView *playlistTableView;
@property (nonatomic, readonly) PlaylistTableDataSource *playlistTableDataSource;

// Collection/Thumbnail Views
@property (nonatomic, strong, readwrite) PDFView *previewPDFView;
@property (nonatomic, readonly) BasePDFThumbnailView *previewPDFThumbnailView;
@property (nonatomic, readonly) BasePDFThumbnailView *liveviewPDFThumbnailView;
@property (nonatomic, readonly) BaseCollectionView *previewCollectionView;
@property (nonatomic, readonly) BaseCollectionView *liveviewCollectionView;

// Drawer
@property (nonatomic, readonly) NSDrawer *songsDrawer;
@property (nonatomic, readonly) NSDrawer *pdfsDrawer;
@property (nonatomic, readonly) SongsDrawerViewController *songsDrawerViewController;
@property (nonatomic, readonly) PDFsDrawerViewController *pdfsDrawerViewController;

// Song creation
@property (nonatomic, readonly) NewSongWindowController *newSongWindowController;
@property (nonatomic, readonly) EditSongWindowController *editSongWindowController;

// Periphals
@property (nonatomic, readonly) ProgressWindowController *progressWindowController;

/***********
 * METHODS *
 ***********/

// Initialization
- (void) setupObservers;
- (void) setupPDFViews;

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

// Preview
- (void) updateThumbnailSize;

@end