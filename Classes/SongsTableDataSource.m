#import "SongsTableDataSource.h"

#import "SongImporter.h"

@implementation SongsTableDataSource

/*
 * This method gets called whenever somebody hovers a drag over our Songlist.
 * Depending on which value we return, the cursor indicates the user's possibitlies.
 */
- (NSDragOperation) tableView:(NSTableView*)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)operation {
  return NSDragOperationCopy;
}

- (BOOL) tableView:(NSTableView*)table acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)targetRow dropOperation:(NSTableViewDropOperation)operation {
  
  NSArray *paths = [[info draggingPasteboard] propertyListForType:NSFilenamesPboardType];
  NSString *path = [paths objectAtIndex:0];
  
  SongImporter *importer = [[SongImporter alloc] initWithPath:path];
  debugLog(@"Activating Importer...");
  [importer import];
  //[importer release];
  
  return NO;
}


@end
