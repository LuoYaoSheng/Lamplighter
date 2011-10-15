#import "SongsDrawerViewController.h"

#import "ApplicationDelegate.h"
#import "SongsTableDataSource.h"
#import "MainWindowController.h"
#import "NewSongWindowController.h"
#import "EditSongWindowController.h"
#import "PreviewController.h"

@implementation SongsDrawerViewController

@synthesize songsTableColumn, songsTableView, newSongButton;

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[SongsDrawerViewController] awakeFromNib");
  [self setupSongsTable];
  [[self view] setNextResponder:[[NSApp mainWindowController] window]];
}

- (void) setupSongsTable {
  [[self songsTableView] setDataSource:self.songsTableDataSource];
  [[self songsTableView] setDelegate:[[NSApp mainWindowController] previewController]];
  [[self songsTableView] setNextKeyView:[[NSApp mainWindowController] playlistTableView]];
  [[self songsTableView] setTarget:self];
  [[self songsTableView] setDoubleAction: @selector(songsTableViewDoubleClicked:)];
  [[self songsTableColumn] bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"arrangedObjects.title" options:nil];
}

/***************
 * GUI Actions *
 ***************/

- (IBAction) songsTableViewDoubleClicked:sender {
  [[[NSApp mainWindowController] editSongWindowController] editSong:sender];
}

- (IBAction) newSong:sender {
  [[[NSApp mainWindowController] newSongWindowController] newSong:self];
}

/*********************
 * TABLE DATA SOURCE *
 *********************/

- (SongsTableDataSource*) songsTableDataSource {
  if (songsTableDataSource) return songsTableDataSource;
  songsTableDataSource = [SongsTableDataSource new];
  return songsTableDataSource;
}

@end