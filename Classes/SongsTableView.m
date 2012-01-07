#import "SongsTableView.h"

#import "Song.h"
#import "ApplicationDelegate.h"
#import "SongsArrayController.h"

@implementation SongsTableView

- (void) deleteSelectedItem {
  NSUInteger firstSelectedRow = [[self selectedRowIndexes] firstIndex];
  [[NSApp songsArrayController] remove:self];
  [[NSApp songsArrayController] setSelectionIndex:firstSelectedRow];
}

- (NSString*) warningMessage {
  return NSLocalizedString(@"song.warning.delete", nil);
}

- (NSDragOperation) draggingSourceOperationMaskForLocal:(BOOL)flag {
  return NSDragOperationCopy;
}

@end
