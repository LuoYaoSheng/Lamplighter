@class ApplicationDelegate;
@class SongsDrawerViewController;
@class SongsDrawer;
@class NewSongWindowController;

@interface MainWindowController : NSWindowController {
  
  IBOutlet ApplicationDelegate *applicationDelegate;

  SongsDrawerViewController *songsDrawerViewController;
  SongsDrawer *songsDrawer;
  NewSongWindowController *newSongWindowController;

  IBOutlet NSMenuItem *toggleSongsMenuItem;
}


@property (nonatomic, retain, readonly) ApplicationDelegate *applicationDelegate;

// Drawer
@property (nonatomic, retain, readonly) SongsDrawer *songsDrawer;

// View Controllers
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;
@property (nonatomic, retain, readonly) NewSongWindowController *newSongWindowController;

// Handling the Drawer
- (IBAction) toggleSongsDrawer:(id)sender;
- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;

// New Song


@end
