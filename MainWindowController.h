@class SongsDrawerViewController;
@class SongsDrawer;

@interface MainWindowController : NSWindowController {

  SongsDrawerViewController *songsDrawerViewController;
  SongsDrawer *songsDrawer;

  IBOutlet NSMenuItem *toggleSongsMenuItem;
}

-(void) loadSongsDrawerViewController;
-(void) loadSongsDrawer;
-(IBAction) toggleSongsDrawer:(id)sender;

@end
