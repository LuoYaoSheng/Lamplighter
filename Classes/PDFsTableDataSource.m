#import "PDFsTableDataSource.h"

@implementation PDFsTableDataSource

/*
 * This method gets called whenever somebody hovers a drag over our Songlist.
 * Depending on which value we return, the cursor indicates the user's possibitlies.
 */
- (NSDragOperation) tableView:(NSTableView*)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)operation {
  NSDragOperation result = NSDragOperationNone;
  // Generally, we only accept drops between lines, not onto lines
  if (operation == NSTableViewDropAbove) {
    result = NSDragOperationCopy;
  }
  return result;
}

- (BOOL) tableView:(NSTableView*)table acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)targetRow dropOperation:(NSTableViewDropOperation)operation {
  
  //NSArray *paths = [[info draggingPasteboard] propertyListForType:NSFilenamesPboardType];
  //NSString *path = [paths objectAtIndex:0];
  
  debugLog(@"Activating Importer...");
  
  return NO;
}


@end
