#import "PlaylistTableDataSource.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"

@implementation PlaylistTableDataSource

/*
 * This method gets called whenever somebody hovers a drag over our Playlist.
 * Depending on which value we return, the cursor indicates the user's possibitlies.
 */
- (NSDragOperation) tableView:(NSTableView*)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)operation {
  // First of all, we won't allow anything to be dropped here
  NSDragOperation result = NSDragOperationNone;
  // Generally, we only accept drops between lines, not onto lines
  if (operation == NSTableViewDropAbove) {
    if ([info draggingSource] == [[NSApp  mainWindowController] playlistTableView]) {
			result = NSDragOperationMove;
    } else {
      // All other drops indicate a copy symbol
      result = NSDragOperationCopy;
    }
  }
  return result;
}

/*
 * This method gets called whenever somebody drops something into our Playlist.
 * Depending on whether the object came from another table or whether the object
 * was merely reordered within the Playlist, we will allow it or deny it.
 */
- (BOOL) tableView:(NSTableView*)table acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)targetRow dropOperation:(NSTableViewDropOperation)operation {

  // First, let's check out whether a Song has been dropped into our Playlist
  NSString *urlString = [[info draggingPasteboard] stringForType:SongDataType];
  NSURL *url = [NSURL URLWithString:urlString];
  
  // Second, we ensure that the Song already exists in our database
  NSManagedObjectID *objectID = [[NSApp persistentStoreCoordinator] managedObjectIDForURIRepresentation:url];
  id object = [[NSApp managedObjectContext] objectRegisteredForID:objectID];
  if (object == nil) return NO;
  
  
  // Then we check out where the drag came from. Here, it came from the Songs Table in the Drawer.
  if ([info draggingSource] == [[[NSApp  mainWindowController] songsDrawerViewController] songsTableView]) {

    // In that case, add the Song only if it doesn't already exist.
    if (!([[[NSApp playlistArrayController] arrangedObjects] containsObject:object])) {
      [[NSApp playlistArrayController] addObject:object];
      return YES;
    }
    
  // Then, it may come from the Playlist table itself
  } else if ([info draggingSource] == [[NSApp  mainWindowController] playlistTableView]) {
    
    // If the song is not yet in the Playlist, we just move the object to another position
    // If the object is moved to a position further below, we need to adjust the target row,
    // because we temporarily delete the object while repositioning
    int sourceRow = [[[NSApp playlistArrayController] arrangedObjects] indexOfObject:object];
    if (sourceRow < targetRow) targetRow -= 1;
    // Remove and add the object at the right position
    [[NSApp playlistArrayController] removeObject:object];
    [[NSApp playlistArrayController] insertObject:object atArrangedObjectIndex:targetRow];
    return YES;    
  }
  return NO;
}

- (BOOL) optionKeyPressed {
  // Have a quick look at whether the OPTION key is held down (meaning "copy")
  NSEvent *currentEvent = [NSApp currentEvent];
  return ([currentEvent modifierFlags] & NSAlternateKeyMask) != 0;
}  

@end