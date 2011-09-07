#import "MainWindowController.h"
#import "SongsDrawerViewController.h"

@implementation MainWindowController

-(void) awakeFromNib {
  debugLog(@"[MainWindowController] awakeFromNib"); 
  songsDrawerViewController = [[SongsDrawerViewController alloc] initWithNibName:@"SongsDrawer" bundle:NULL];
  [songsDrawerViewController loadView];
}

@end
