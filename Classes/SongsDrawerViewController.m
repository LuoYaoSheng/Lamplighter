#import "SongsDrawerViewController.h"

#import "ApplicationDelegate.h"

@implementation SongsDrawerViewController

@synthesize tableColumn;

-(void) awakeFromNib {
  debugLog(@"[SongsDrawerViewController] awakeFromNib");
  debugLog(@"[SongsDrawerViewController] NSApp: %@", NSApp);
  
  [[self tableColumn] bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.title" options:nil];
}

@end
