#import "SongsDrawerViewController.h"

#import "ApplicationDelegate.h"
#import "SongsTableDataSource.h"
#import "MainWindowController.h"
#import "NewSongWindowController.h"

@implementation SongsDrawerViewController

@synthesize tableColumn, newSongButton;

-(void) awakeFromNib {
  debugLog(@"[SongsDrawerViewController] awakeFromNib");
  
  [[self tableColumn] bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.title" options:nil];
}


- (SongsTableDataSource*) songsTableDataSource {
  if (songsTableDataSource) return songsTableDataSource;
  songsTableDataSource = [SongsTableDataSource new];
  return songsTableDataSource;
}

- (IBAction) newSong:(id)sender {
  [[[NSApp mainWindowController] newSongWindowController] newSong:self];
  
}

@end
