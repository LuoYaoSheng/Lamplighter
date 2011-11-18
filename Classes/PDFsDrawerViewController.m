#import "PDFsDrawerViewController.h"

#import "ApplicationDelegate.h"
#import "PDFsTableDataSource.h"
#import "MainWindowController.h"
#import "PreviewController.h"

@implementation PDFsDrawerViewController

@synthesize tableColumn, tableView;

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  debugLog(@"[PDFsDrawerViewController] awakeFromNib");
  [self setupTableView];
  [[self view] setNextResponder:[[NSApp mainWindowController] window]];
}

- (void) setupTableView {
  [[self tableView] setDataSource:self.pdfsTableDataSource];
  [[self tableView] setDelegate:[[NSApp mainWindowController] previewController]];
  [[self tableView] setNextKeyView:[[NSApp mainWindowController] playlistTableView]];
  [[self tableView] setTarget:self];
  [[self tableView] registerForDraggedTypes: [NSArray arrayWithObject:NSFilenamesPboardType]];
  [[self tableColumn] bind:NSValueBinding toObject:[NSApp pdfsArrayController] withKeyPath:@"arrangedObjects.title" options:nil];
}

/*********************
 * TABLE DATA SOURCE *
 *********************/

- (PDFsTableDataSource*) pdfsTableDataSource {
  if (pdfsTableDataSource) return pdfsTableDataSource;
  pdfsTableDataSource = [PDFsTableDataSource new];
  return pdfsTableDataSource;
}

@end