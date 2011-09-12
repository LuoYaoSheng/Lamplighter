@class SongsDrawerViewController;
@class SongsDrawer;

@interface MainWindowController : NSWindowController {

  SongsDrawerViewController *songsDrawerViewController;
  SongsDrawer *songsDrawer;

  IBOutlet NSMenuItem *toggleSongsMenuItem;
}

// View Controllers
@property (nonatomic, retain, readonly) SongsDrawerViewController *songsDrawerViewController;

-(void) loadSongsDrawer;
-(IBAction) toggleSongsDrawer:(id)sender;

- (void) ensureSpaceForDrawer:(NSDrawer*)drawer;

@end
