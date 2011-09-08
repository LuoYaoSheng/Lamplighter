#import "SongsDrawerViewController.h"
#import "SongsDrawer.h"

@implementation SongsDrawerViewController

@synthesize mainWindow;

-(void) awakeFromNib {
  debugLog(@"[SongsDrawerViewController] awakeFromNib"); 
  [self loadSongsDrawer];
}

-(void) loadSongsDrawer {
  //songsDrawer = [SongsDrawer alloc];
  NSSize contentSize = NSMakeSize(100, 100);
  songsDrawer = [[SongsDrawer alloc] initWithContentSize:contentSize preferredEdge:NSMinXEdge];
  [songsDrawer setContentView:self.view];
  [songsDrawer setParentWindow:[self mainWindow]];
  [songsDrawer open];
}

@end
