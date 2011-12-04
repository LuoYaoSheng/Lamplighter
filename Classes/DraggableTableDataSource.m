#import "DraggableTableDataSource.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"

@implementation DraggableTableDataSource

- (NSInteger) numberOfRowsInTableView:(NSTableView*)table {
  // Fall back to the binding
  return 0;
}

- (id) tableView:(NSTableView*)table objectValueForTableColumn:(NSTableColumn*)column row:(NSInteger)row {
  // Fall back to the binding
  return nil;  
}

/*
 * When dragging, copy the Song object URI into the pasteboard as an Lamplighter SongDataType
 */
- (BOOL)tableView:(NSTableView *)table writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)internalPasteboard {
  
  NSPasteboard *dragPasteboard = [NSPasteboard pasteboardWithName:NSDragPboard];
  
  BOOL success = NO;
  NSDictionary *infoForBinding = [table infoForBinding:NSContentBinding];
  if (infoForBinding != nil) {
    // OK, so we have an ArrayController behind this TableView. Which is it?
    NSArrayController *arrayController = [infoForBinding objectForKey:NSObservedObjectKey];
    
    // Eventually this code can handle multiple selects, but we'll just have only one selected anyway
    NSArray *objects = [[arrayController arrangedObjects] objectsAtIndexes:rowIndexes];
    NSMutableArray *urls = [NSMutableArray array];
    NSString *dataType;
    
    for (id object in objects) {
      NSURL *url;
      if (table == [[[NSApp mainWindowController] pdfsDrawerViewController] tableView]) {
        // URL to a PDF file on disk
        dataType = PDFDataType;
        //url = (NSURL*)object;
        url = [[(NSManagedObject*)object objectID] URIRepresentation];
      } else {
        // Core Data (currently just Song entities)
        dataType = SongDataType;
        url = [[(NSManagedObject*)object objectID] URIRepresentation];
      }
      [urls addObject:url];
    }

    [internalPasteboard declareTypes:[NSArray arrayWithObject:dataType] owner:nil];
    [internalPasteboard addTypes:[NSArray arrayWithObject:dataType] owner:nil];
    [internalPasteboard setString:[urls componentsJoinedByString:@", "] forType:dataType];  

    NSMutableArray *filenameExtensions = [NSMutableArray array];
    if (dataType == PDFDataType) {
      [filenameExtensions addObject:@"pdf"];
    } else {
      [filenameExtensions addObject:@"txt"];
    }
    [dragPasteboard setPropertyList:filenameExtensions forType:NSFilesPromisePboardType];

    success = YES;
  }
  return success;
}

- (NSArray *)tableView:(NSTableView *)aTableView namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination forDraggedRowsWithIndexes:(NSIndexSet *)indexSet {

  debugLog(@"two");
  NSArray *draggedFilenames = [NSArray arrayWithObjects:@"one.txt", @"two.txt", nil];
  
  for (NSString *filename in draggedFilenames) {
    
    //NSString *fullPathToOriginal = nil;
    //NSString *destPath = [[dropDestination path] stringByAppendingPathComponent:filename];
    
    
  }
  debugLog(@"dropDestination: %@", dropDestination);
  debugLog(@"draggedFilenames: %@", draggedFilenames);

  return draggedFilenames;
}

@end