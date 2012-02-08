#import "PDFsTableView.h"

#import "ApplicationDelegate.h"
#import "PDFsArrayController.h"
#import "PlaylistArrayController.h"

@implementation PDFsTableView

- (void) deleteSelectedItem {
  NSUInteger firstSelectedRow = [[self selectedRowIndexes] firstIndex];
  [[NSApp playlistArrayController] removeObjects:[[NSApp pdfsArrayController] selectedObjects]];
  [[NSApp pdfsArrayController] remove:self];
  [[NSApp pdfsArrayController] setSelectionIndex:firstSelectedRow];
  DLog(@"Deleting selected PDF.");
}


- (NSString*) warningMessage {
  return NSLocalizedString(@"pdf.warning.delete", nil);
}

@end
