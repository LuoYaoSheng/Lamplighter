#import "DraggableTableDataSource.h"

@interface PlaylistTableDataSource : DraggableTableDataSource {

}

- (void) addObject:(id)object;
- (void) moveObject:(id)object toRow:(NSInteger)targetRow;

@end
