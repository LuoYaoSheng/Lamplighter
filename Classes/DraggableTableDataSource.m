#import "DraggableTableDataSource.h"


@implementation DraggableTableDataSource

- (NSInteger) numberOfRowsInTableView:(NSTableView*)table {
  // Fall back to the binding
  return 0;
}

- (id) tableView:(NSTableView*)table objectValueForTableColumn:(NSTableColumn*)column row:(NSInteger)row {
  // Fall back to the binding
  return nil;  
}

// When dragging, copy the Song object URI into the pasteboard as an Lamplighter SongDataType
- (BOOL)tableView:(NSTableView *)table writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard {
  BOOL success = NO;
  NSDictionary *infoForBinding = [table infoForBinding:NSContentBinding];
  if (infoForBinding != nil) {
    // OK, so we have an ArrayController behind this TableView. Which is it?
    NSArrayController *arrayController = [infoForBinding objectForKey:NSObservedObjectKey];
    
    // Eventually this code can handle multiple selects, but we'll just have only one selected anyway
    NSArray *objects = [[arrayController arrangedObjects] objectsAtIndexes:rowIndexes];
    NSMutableArray *objectIDs = [NSMutableArray array];
    unsigned int i, count = [objects count];
    for (i = 0; i < count; i++) {
      NSManagedObject *item = [objects objectAtIndex:i];
      NSManagedObjectID *objectID = [item objectID];
      NSURL *representedURL = [objectID URIRepresentation];
      [objectIDs addObject:representedURL];
    }
    [pboard declareTypes:[NSArray arrayWithObject:SongDataType] owner:nil];
    [pboard addTypes:[NSArray arrayWithObject:SongDataType] owner:nil];
    success = [pboard setString:[objectIDs componentsJoinedByString:@", "] forType:SongDataType];        
  }
  
  return success;
}


@end
