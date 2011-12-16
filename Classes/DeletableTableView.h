@interface DeletableTableView : NSTableView

- (void) deleteSelectedItem;
- (void) areYouSure;
- (NSString*) warningMessage;

@end
