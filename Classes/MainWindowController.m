#import "MainWindowController.h"

#import "ApplicationDelegate.h"
#import "SongsDrawerViewController.h"
#import "SongsDrawer.h"
#import "NewSongWindowController.h"
#import "PlaylistTableDataSource.h"
#import "SongsArrayController.h"
#import "ProjectorController.h"

@implementation MainWindowController

@synthesize applicationDelegate;
@synthesize playlistTableColumn, playlistTableView;

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[MainWindowController] awakeFromNib");
  [self setupPlaylistTable];
}

/************
 * PLAYLIST *
 ************/

- (void) setupPlaylistTable {
  [playlistTableView registerForDraggedTypes: [NSArray arrayWithObject:SongDataType]];
  [[self playlistTableView] setDataSource:self.playlistTableDataSource];
  [[self playlistTableView] setDelegate:self.projectorController];
  [[self playlistTableColumn] bind:NSValueBinding toObject:[NSApp playlistArrayController] withKeyPath:@"arrangedObjects.title" options:nil];
  
}

- (PlaylistTableDataSource*) playlistTableDataSource {
  if (playlistTableDataSource) return playlistTableDataSource;
  playlistTableDataSource = [PlaylistTableDataSource new];
  return playlistTableDataSource;
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

- (IBAction) toggleSongsDrawer:(id)sender {
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

/*************
 * PROJECTOR *
 *************/

- (ProjectorController*) projectorController {
  if (projectorController) return projectorController;
	projectorController = [ProjectorController new];
  return projectorController;
}

/*************
 * GUI ITEMS *
 *************/

- (BOOL) validateMenuItem:(NSMenuItem*)item{
  debugLog(@"[MainWindowController] validateMenuItem");
  BOOL result = YES;
  
  if ([item action] == @selector(toggleSongsDrawer:)) {
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