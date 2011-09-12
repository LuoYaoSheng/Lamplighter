#import "SongsDrawerViewController.h"

#import "ApplicationDelegate.h"
#import "SongsTableDataSource.h"

@implementation SongsDrawerViewController

@synthesize tableColumn;

-(void) awakeFromNib {
  debugLog(@"[SongsDrawerViewController] awakeFromNib");
  
  [[self tableColumn] bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.title" options:nil];
}


- (SongsTableDataSource*) songsTableDataSource {
  if (songsTableDataSource) return songsTableDataSource;
  songsTableDataSource = [SongsTableDataSource new];
  return songsTableDataSource;
  
}

@end
