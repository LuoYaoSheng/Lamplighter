#import "MainWindowController.h"
#import "SongsDrawerViewController.h"

@implementation MainWindowController

-(void) awakeFromNib {
  debugLog(@"[MainWindowController] awakeFromNib");
  debugLog(@"[MainWindowController] 1 [self isWindowLoaded] => %i", [self isWindowLoaded]); 
  [self loadSongsDrawerViewController];
}

-(void) loadSongsDrawerViewController {
  if (songsDrawerViewController != NULL) return;
  songsDrawerViewController = [[SongsDrawerViewController alloc] initWithNibName:@"SongsDrawer" bundle:NULL];
  songsDrawerViewController.mainWindow = self.window;
  
  [songsDrawerViewController loadView];
}

@end
