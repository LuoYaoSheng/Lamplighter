@class SongsDrawerViewController;
@class SongsDrawer;
@class NewSongWindowController;

@interface MainWindowController : NSWindowController {

  SongsDrawerViewController *songsDrawerViewController;
  SongsDrawer *songsDrawer;
  NewSongWindowController *newSongWindowController;

  IBOutlet NSMenuItem *toggleSongsMenuItem;
}


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
