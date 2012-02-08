#import "SongsTableView.h"

#import "Song.h"
#import "ApplicationDelegate.h"
#import "SongsArrayController.h"
#import "PlaylistArrayController.h"

@implementation SongsTableView

- (void) deleteSelectedItem {
  NSUInteger firstSelectedRow = [[self selectedRowIndexes] firstIndex];
  [[NSApp playlistArrayController] removeObjects:[[NSApp songsArrayController] selectedObjects]];
  [[NSApp songsArrayController] remove:self];
  [[NSApp songsArrayController] setSelectionIndex:firstSelectedRow];
}

- (NSString*) warningMessage {
  return NSLocalizedString(@"song.warning.delete", nil);
}

// When dragging to Finder
- (NSDragOperation) draggingSourceOperationMaskForLocal:(BOOL)flag {
  return NSDragOperationCopy;
}

@end
