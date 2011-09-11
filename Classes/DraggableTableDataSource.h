#import <Cocoa/Cocoa.h>

@interface DraggableTableDataSource : NSObject {

}

- (BOOL)tableView:(NSTableView *)table writeRowsWithIndexes:(NSIndexSet *)rows toPasteboard:(NSPasteboard*)pasteboard;

@end
