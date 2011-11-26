#import "DraggableTableDataSource.h"

@interface PlaylistTableDataSource : DraggableTableDataSource {

}

- (void) moveObject:(id)object toRow:(NSInteger)targetRow;

@end
