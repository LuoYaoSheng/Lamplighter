#import "SongsDrawerViewController.h"

#import "ApplicationDelegate.h"
#import "SongsTableDataSource.h"
#import "MainWindowController.h"
#import "NewSongWindowController.h"

@implementation SongsDrawerViewController

@synthesize tableColumn, tableView, newSongButton;

-(void) awakeFromNib {
  debugLog(@"[SongsDrawerViewController] awakeFromNib");
  [[self tableView] setDataSource:self.songsTableDataSource];
  [[self tableColumn] bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"arrangedObjects.title" options:nil];
}


- (SongsTableDataSource*) songsTableDataSource {
  if (songsTableDataSource) return songsTableDataSource;
  songsTableDataSource = [SongsTableDataSource new];
  return songsTableDataSource;
}

- (IBAction) newSong:sender {
  [[[NSApp mainWindowController] newSongWindowController] newSong:self];
}

@end
