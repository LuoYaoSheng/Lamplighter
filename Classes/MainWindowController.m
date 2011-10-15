#import "MainWindowController.h"

#import "ApplicationDelegate.h"
#import "SongsDrawerViewController.h"
#import "SongsDrawer.h"
#import "NewSongWindowController.h"
#import "EditSongWindowController.h"
#import "PlaylistTableDataSource.h"
#import "SongsArrayController.h"
#import "ProjectorController.h"
#import "PreviewController.h"
#import "LiveviewController.h"
#import "ProjectorController.h"
#import "BaseCollectionView.h"

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
  [self setupControllerObservers];
  [self setupMenuLocalization];
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

- (void) setupControllerObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self.liveviewController selector:@selector(slideWasDoubleClickedNotification:) name:SlideWasDoubleClickedNotification object:nil];
}

/**********
 * DRAWER *
 **********/

- (SongsDrawer*) songsDrawer {
  if (songsDrawer) return songsDrawer;
  songsDrawer = [[SongsDrawer alloc] initWithContentSize:NSMakeSize(200, 100) preferredEdge:NSMinXEdge];
  [songsDrawer setContentView:songsDrawerViewController.view];
  [songsDrawer setParentWindow:self.window];
  [songsDrawer setMinContentSize:NSMakeSize(160, 0)];
  [songsDrawer setMaxContentSize:NSMakeSize(400, 10000)];
  return songsDrawer;
}

- (SongsDrawerViewController*) songsDrawerViewController {
  if (songsDrawerViewController) return songsDrawerViewController;
  songsDrawerViewController = [[SongsDrawerViewController alloc] initWithNibName:@"SongsDrawer" bundle:NULL];
  return songsDrawerViewController;
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

/************************
 * MENU/TOOLBAR ACTIONS *
 ************************/

- (IBAction) toggleSongsDrawerAction:sender {
  // Initialize the Drawer by simply calling it
  [self songsDrawerViewController];
  NSDrawerState state = [[self songsDrawer] state];
  
  if (state == NSDrawerOpenState || state == NSDrawerOpeningState) {
    [songsDrawer close];
  } else {
    [[NSApp songsArrayController] ensureContentIsLoaded];
    [self ensureSpaceForDrawer:songsDrawer];
    //[presentasionsDrawer close];
    [songsDrawer openOnEdge:NSMinXEdge];
  }
}

- (IBAction) toggleLiveAction:sender {
  [[NSApp projectorController] toggleLive];
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

- (BOOL) validateMenuItem:(NSMenuItem*)item{
  BOOL result = YES;
  // Enabled/Disabled Validation
  if ([item action] == @selector(projectorGoBlankAction:)) {
    if (![[NSApp projectorController] isLive] || [[NSApp projectorController] isBlank]) result = NO;
  }
  // Text changes
  if ([item action] == @selector(toggleSongsDrawerAction:)) {
    NSDrawerState state = [songsDrawer state];
    if (state == NSDrawerOpenState || state == NSDrawerOpeningState) {
      [item setTitle:NSLocalizedString(@"menu.songs.hide", nil)];
    } else {
      [item setTitle:NSLocalizedString(@"menu.songs.show", nil)];
    }
  }
  return (result);
}

@end