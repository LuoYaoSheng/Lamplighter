#import "SongsDrawerViewController.h"

#import "ApplicationDelegate.h"
#import "SongsTableDataSource.h"
#import "MainWindowController.h"
#import "NewSongWindowController.h"
#import "EditSongWindowController.h"
#import "PreviewController.h"

@implementation SongsDrawerViewController

@synthesize songsTableColumn, songsTableView, newSongButton, searchField;

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
  [[self songsTableView] registerForDraggedTypes: [NSArray arrayWithObject:NSFilenamesPboardType]];
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

- (IBAction)filterSongs:sender {
  NSMutableString *searchText = [NSMutableString stringWithString:[self.searchField stringValue]];
  
  if ([searchText length] == 0) {
    [[NSApp songsArrayController] setFilterPredicate:nil];
    return;
  }
  
  NSArray *searchTerms = [searchText componentsSeparatedByString:@" "];
  
  if ([searchTerms count] == 1) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(keywords contains[cd] %@)", searchText];
    [[NSApp songsArrayController] setFilterPredicate:predicate];
  } else {
    NSMutableArray *subPredicates = [[NSMutableArray alloc] init];
    for (NSString *term in searchTerms) {
      NSPredicate *p = [NSPredicate predicateWithFormat:@"(keywords contains[cd] %@)", term];
      [subPredicates addObject:p];
    }
    NSPredicate *cp = [NSCompoundPredicate andPredicateWithSubpredicates:subPredicates];
    
    [[NSApp songsArrayController] setFilterPredicate:cp];
  }
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