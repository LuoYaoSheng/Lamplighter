#import "PlaylistDataSource.h"


@implementation PlaylistDataSource


- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)operation {
  // First of all, we won't allow anything to be dropped here
  NSDragOperation result = NSDragOperationNone;
  // Generally, we only accept drops between lines, not onto lines
  if (operation == NSTableViewDropAbove) {
    if ([info draggingSource] == [[NSApp delegate] playlistTable]) {
			result = NSDragOperationMove;
    } else {
      // All other drops indicate a copy symbol
      result = NSDragOperationCopy;
    }
  }
  return result;
}

- (BOOL)tableView:(NSTableView*)table acceptDrop:(id <NSDraggingInfo>)info row:(int)targetRow dropOperation:(NSTableViewDropOperation)operation {
  
  NSString *urlString = [[info draggingPasteboard] stringForType:SongDataType];
  NSURL *url = [NSURL URLWithString:urlString];
  
  NSManagedObjectID *objectID = [[[NSApp delegate] persistentStoreCoordinator] managedObjectIDForURIRepresentation:url];
  id object = [[[NSApp delegate] managedObjectContext] objectRegisteredForID:objectID];
  
  if (object == nil) return NO;
  
  
  // Firstly, the drag can come from the Songs Database.
  if ([info draggingSource] == [[NSApp delegate] songsTable]) {

    // In that case, add the song only if it doesn't exist already, because it's only a reference to a Core Data object
    if (!([[[[NSApp delegate] playlistArrayController] arrangedObjects] containsObject:object])) {
      [[[NSApp delegate] playlistArrayController] addObject:object];
      return YES;
    }
    
  // Secondly, it may come from the playlist table itself
  } else if ([info draggingSource] == [[NSApp delegate] playlistTable]) {

    // That means that the object is already in the playlist table
    // In that case it makes a difference whether the OPTION key is held down or not
    // But we don't implement that yet
    /*
    if ([self optionKeyPressed]) {
      // If so, it is save to just duplicate the object
      [[[NSApp delegate] playlistArrayController] insertObject:object atArrangedObjectIndex:targetRow];
      return 
    } else {
    */
    
    // If not, we just move the object to another position
    // If the object is moved to a position further below, we need to adjust the target row, because we deleted the object
    int sourceRow = [[[[NSApp delegate] playlistArrayController] arrangedObjects] indexOfObject:object];
    if (sourceRow < targetRow) targetRow -= 1;
    // Remove and add the object at the right position
    [[[NSApp delegate] playlistArrayController] removeObject:object];
    [[[NSApp delegate] playlistArrayController] insertObject:object atArrangedObjectIndex:targetRow];
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
