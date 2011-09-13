@interface DraggableTableDataSource : NSObject <NSTableViewDataSource> {

}

- (BOOL)tableView:(NSTableView *)table writeRowsWithIndexes:(NSIndexSet *)rows toPasteboard:(NSPasteboard*)pasteboard;

@end
