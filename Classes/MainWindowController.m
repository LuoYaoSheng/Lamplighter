#import "MainWindowController.h"

#import "ApplicationDelegate.h"
#import "SongsDrawerViewController.h"
#import "PDFsDrawerViewController.h"
#import "NewSongWindowController.h"
#import "EditSongWindowController.h"
#import "PlaylistTableDataSource.h"
#import "SongsArrayController.h"
#import "ProjectorController.h"
#import "PreviewController.h"
#import "LiveviewController.h"
#import "ProjectorController.h"
#import "BaseCollectionView.h"
#import "ProgressWindowController.h"

@implementation MainWindowController

@synthesize applicationDelegate;
@synthesize playlistTableColumn, playlistTableView;
@synthesize previewCollectionView, liveviewCollectionView;

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[MainWindowController] awakeFromNib");
  [self setupPlaylistTable];
  [self setupObservers];
  [self setupMenuLocalization];
}

- (void) setupObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self.liveviewCollectionView selector:@selector(projectorSlideViewWillDrawNotification:) name:ProjectorSlideViewWillDraw object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self.previewCollectionView selector:@selector(projectorSlideViewWillDrawNotification:) name:ProjectorSlideViewWillDraw object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self.liveviewController selector:@selector(slideViewWasDoubleClickedNotification:) name:SlideViewWasDoubleClickedNotification object:nil];
}

/************
 * PLAYLIST *
 ************/

- (void) setupPlaylistTable {
  [playlistTableView registerForDraggedTypes: [NSArray arrayWithObject:SongDataType]];
  [[self playlistTableView] setDataSource:self.playlistTableDataSource];
  [[self playlistTableView] setDelegate:self.previewController];
  [[self playlistTableColumn] bind:NSValueBinding toObject:[NSApp playlistArrayController] withKeyPath:@"arrangedObjects.title" options:nil];
  [[self playlistTableView] setNextKeyView:[[self songsDrawerViewController] songsTableView]]; 
}

- (PlaylistTableDataSource*) playlistTableDataSource {
  if (playlistTableDataSource) return playlistTableDataSource;
  playlistTableDataSource = [PlaylistTableDataSource new];
  return playlistTableDataSource;
}

/**********
 * DRAWER *
 **********/

- (NSDrawer*) songsDrawer {
  if (songsDrawer) return songsDrawer;
  songsDrawer = [[NSDrawer alloc] initWithContentSize:NSMakeSize(200, 100) preferredEdge:NSMinXEdge];
  [songsDrawer setContentView:songsDrawerViewController.view];
  [songsDrawer setParentWindow:self.window];
  [songsDrawer setMinContentSize:NSMakeSize(160, 0)];
  [songsDrawer setMaxContentSize:NSMakeSize(400, 10000)];
  return songsDrawer;
}

- (NSDrawer*) pdfsDrawer {
  if (pdfsDrawer) return pdfsDrawer;
  pdfsDrawer = [[NSDrawer alloc] initWithContentSize:NSMakeSize(200, 100) preferredEdge:NSMinXEdge];
  [pdfsDrawer setContentView:pdfsDrawerViewController.view];
  [pdfsDrawer setParentWindow:self.window];
  [pdfsDrawer setMinContentSize:NSMakeSize(160, 0)];
  [pdfsDrawer setMaxContentSize:NSMakeSize(400, 10000)];
  return pdfsDrawer;
}

- (SongsDrawerViewController*) songsDrawerViewController {
  if (songsDrawerViewController) return songsDrawerViewController;
  songsDrawerViewController = [[SongsDrawerViewController alloc] initWithNibName:@"SongsDrawer" bundle:NULL];
  return songsDrawerViewController;
}

- (PDFsDrawerViewController*) pdfsDrawerViewController {
  if (pdfsDrawerViewController) return pdfsDrawerViewController;
  pdfsDrawerViewController = [[PDFsDrawerViewController alloc] initWithNibName:@"PDFsDrawer" bundle:NULL];
  return pdfsDrawerViewController;
}

- (void) ensureSpaceForDrawer:(NSDrawer*)drawer {
  // Get the current positions of the involved objects
  NSRect screenPosition = [[self.window screen] frame];
  NSRect windowPosition = [self.window frame];
  NSRect drawerPosition = [[drawer contentView] frame];
  drawerPosition.size.width += drawer.trailingOffset; // Adding some extra padding to go sure
  
  // Calculate how much space we have for a drawer on the left side. Add some additional pixels to be sure.
  int leftSpace = windowPosition.origin.x - drawerPosition.size.width;
  int rightSpace = screenPosition.size.width - windowPosition.origin.x - windowPosition.size.width;
  
  if (leftSpace < 0) {
    windowPosition.origin.x -= leftSpace;
    // Calculate whether the right edge of the main window is or will be outside of the screen to the right and prevent that.
    if (rightSpace < drawerPosition.size.width) {
      windowPosition.size.width = screenPosition.size.width - windowPosition.origin.x;
    }
    
    NSDictionary *windowResize;
    windowResize = [NSDictionary dictionaryWithObjectsAndKeys: self.window, NSViewAnimationTargetKey, [NSValue valueWithRect: windowPosition], NSViewAnimationEndFrameKey, nil];
    
    NSArray *animations;
    animations = [NSArray arrayWithObjects: windowResize, nil];
    
    NSViewAnimation *animation;
    animation = [[NSViewAnimation alloc] initWithViewAnimations: animations];
    
    [animation setAnimationBlockingMode: NSAnimationNonblocking];
    [animation setDuration: 0.38];
    [animation startAnimation];
    [animation release];
  }
}

- (BOOL) isDrawerOpen {
  NSDrawerState state = [songsDrawer state];
  return [songsDrawer state] == NSDrawerOpenState || [songsDrawer state] == NSDrawerOpeningState;
}

/*****************
 * SONG CREATION *
 *****************/

- (NewSongWindowController*) newSongWindowController {
  if (newSongWindowController) return newSongWindowController;
	newSongWindowController = [[NewSongWindowController alloc] initWithWindowNibName:@"NewSongWindow"];
  return newSongWindowController;
}

- (EditSongWindowController*) editSongWindowController {
  if (editSongWindowController) return editSongWindowController;
	editSongWindowController = [[EditSongWindowController alloc] initWithWindowNibName:@"EditSongWindow"];
  return editSongWindowController;
}

- (NSWindowController*) progressWindowController {
  if (progressWindowController) return progressWindowController;
	progressWindowController = [[ProgressWindowController alloc] initWithWindowNibName:@"ProgressWindow"];
  return progressWindowController;
}

/************************
 * MENU/TOOLBAR ACTIONS *
 ************************/

- (IBAction) togglePDFsDrawerAction:sender {
  [self pdfsDrawerViewController];
  NSDrawerState state = [self.pdfsDrawer state];
  
  if (state == NSDrawerOpenState || state == NSDrawerOpeningState) {
    [self.pdfsDrawer close];
  } else {
    [self.songsDrawer close];
    [self ensureSpaceForDrawer:self.pdfsDrawer];
    [self.pdfsDrawer openOnEdge:NSMinXEdge];
    
  }
  if ([sender isKindOfClass:[NSToolbarItem class]]) [self validateToolbarItem:sender];
}

- (IBAction) toggleSongsDrawerAction:sender {
  // Initialize the Drawer by simply calling it
  [self songsDrawerViewController];
  NSDrawerState state = [self.songsDrawer state];
  
  if (state == NSDrawerOpenState || state == NSDrawerOpeningState) {
    [self.songsDrawer close];
  } else {
    [self.pdfsDrawer close];
    [[NSApp songsArrayController] ensureContentIsLoaded];
    [self ensureSpaceForDrawer:self.songsDrawer];
    [self.songsDrawer openOnEdge:NSMinXEdge];
    [self.window makeFirstResponder:[songsDrawerViewController searchField]];
    
  }
  if ([sender isKindOfClass:[NSToolbarItem class]]) [self validateToolbarItem:sender];
}

- (IBAction) toggleLiveAction:sender {
  [[NSApp projectorController] toggleLive];
  if ([sender isKindOfClass:[NSToolbarItem class]]) [self validateToolbarItem:sender];
}

- (IBAction) projectorGoBlankAction:sender {
  [self.liveviewController ensureNoSelection];
}

/***********
 * PREVIEW *
 ***********/

- (PreviewController*) previewController {
  if (previewController) return previewController;
	previewController = [PreviewController new];
  return previewController;
}

- (LiveviewController*) liveviewController {
  if (liveviewController) return liveviewController;
	liveviewController = [LiveviewController new];
  return liveviewController;
}

/**********************
 * NSWindowController *
 **********************/

- (BOOL) validateMenuItem:(NSMenuItem*)item {
  BOOL result = YES;
  if ([item action] == @selector(projectorGoBlankAction:)) {
    if (![[NSApp projectorController] isLive] || [[NSApp projectorController] isBlank]) result = NO;
  }
  [self updateMenuItem:item];
  return (result);
}

- (BOOL) validateToolbarItem:(NSToolbarItem*)item {
  BOOL result = YES;
  [self updateToolbarItem:item];
  return (result);
}

/*************
 * GUI ITEMS *
 *************/

/* Let's localize the Menu. I know that we can simply use the built-in Cocoa localization for xib files.
 * However, we're using so many programmatically set strings that we can as well have the entire application
 * in a Localizable.string. After all, a single text file is easier to translate for newbies than having them
 * use Interface Builder.
 */
- (void) setupMenuLocalization {
  [self localizeMenu:[self.window menu]];
}

/* Yes, it's recursion. We iterate over the entire menu and translate every item title.
 * NSLocalizedString is smart enough to "ignore" titles that don't have a translation. 
 */
- (void) localizeMenu:(NSMenu*)theMenu {
  [theMenu setTitle:NSLocalizedString([theMenu title], nil)];
  for (NSMenuItem *loopMenuItem in [theMenu itemArray]) {
    [loopMenuItem setTitle:NSLocalizedString([loopMenuItem title], nil)];
    [self localizeMenu:[loopMenuItem submenu]];
  }
}

- (void) updateToolbarItem:(NSToolbarItem*)item {
  if ([item action] == @selector(toggleLiveAction:)) {
    NSImage *itemImage;
    if ([[NSApp projectorController] isLive]) {
      item.label = NSLocalizedString(@"toolbar.live.stop", nil);
      itemImage = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app_logo_on" ofType:@"icns"]];
    } else {
      item.label = NSLocalizedString(@"toolbar.live.start", nil);
      itemImage = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app_logo" ofType:@"icns"]];
    }
    [NSApp setApplicationIconImage:itemImage];
    item.image = itemImage;
    [itemImage release];
  } else if ([item action] == @selector(toggleSongsDrawerAction:)) {
    if ([songsDrawer state] == NSDrawerOpenState || [songsDrawer state] == NSDrawerOpeningState) {
      item.label = NSLocalizedString(@"toolbar.songs.hide", nil);
    } else {
      item.label = NSLocalizedString(@"toolbar.songs.show", nil);
    }
  } else if ([item action] == @selector(togglePDFsDrawerAction:)) {
    if ([pdfsDrawer state] == NSDrawerOpenState || [pdfsDrawer state] == NSDrawerOpeningState) {
      item.label = NSLocalizedString(@"toolbar.pdfs.hide", nil);
    } else {
      item.label = NSLocalizedString(@"toolbar.pdfs.show", nil);
    }
  }
}

- (void) updateMenuItem:(NSMenuItem*)item {
  if ([item action] == @selector(toggleLiveAction:)) {
    if ([[NSApp projectorController] isLive]) {
      item.title = NSLocalizedString(@"menu.projector.live.stop", nil);
    } else {
      item.title = NSLocalizedString(@"menu.projector.live.start", nil);
    }
  } else if ([item action] == @selector(toggleSongsDrawerAction:)) {
    if ([self isDrawerOpen]) {
      item.title = NSLocalizedString(@"menu.songs.hide", nil);
    } else {
      item.title = NSLocalizedString(@"menu.songs.show", nil);
    }
  }
}

@end