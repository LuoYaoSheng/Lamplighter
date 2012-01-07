#import "PlaylistTableDataSource.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"
#import "PlaylistArrayController.h"

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
      // All other drops (from the internal dragging pasteboard) indicate a copy symbol
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

  id object;
  NSArray *types = [[info draggingPasteboard] types];
  
  if ([types containsObject:PDFDataType]) {
    //object = [NSURL URLWithString:[[info draggingPasteboard] stringForType:PDFDataType]];
    
    NSURL *url = [NSURL URLWithString:[[info draggingPasteboard] stringForType:PDFDataType]];
    // We ensure that the Song already exists in our database (i.e. is committed and saved)
    NSManagedObjectID *objectID = [[NSApp persistentStoreCoordinator] managedObjectIDForURIRepresentation:url];
    object = [[NSApp managedObjectContext] objectRegisteredForID:objectID];

    
  } else if ([types containsObject:SongDataType]) {
    NSURL *url = [NSURL URLWithString:[[info draggingPasteboard] stringForType:SongDataType]];
    // We ensure that the Song already exists in our database (i.e. is committed and saved)
    NSManagedObjectID *objectID = [[NSApp persistentStoreCoordinator] managedObjectIDForURIRepresentation:url];
    object = [[NSApp managedObjectContext] objectRegisteredForID:objectID];
    if (!object) return NO;
    
  } else {
    // We don't accept anything else
    return NO;
  }
  
  if ([info draggingSource] == [[NSApp  mainWindowController] playlistTableView]) {
    [self moveObject:object toRow:targetRow];
  } else  {
    [self addObject:object];
  }
  return YES;
}

- (void) addObject:(id)object {
  // Don't do anything if the object already exists
  if (([[[NSApp playlistArrayController] arrangedObjects] containsObject:object])) return;
  [[NSApp playlistArrayController] addObject:object];
}

- (void) moveObject:(id)object toRow:(NSInteger)targetRow {
  // If the object is moved to a position further below, we need to adjust the target row,
  // because we temporarily delete the object while repositioning
  NSInteger sourceRow = [[[NSApp playlistArrayController] arrangedObjects] indexOfObject:object];
  if (sourceRow < targetRow) targetRow -= 1;
  // Remove and add the object at the right position
  [[NSApp playlistArrayController] removeObject:object];
  [[NSApp playlistArrayController] insertObject:object atArrangedObjectIndex:targetRow];
}  

@end