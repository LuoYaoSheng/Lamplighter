@class Song; 

@interface PreviewController : NSObject <NSTableViewDelegate> {
  
}

// NSTableViewDelegate
- (BOOL) exclusiveTableSelectionFor:(NSTableView*)table;

// Instance methods
- (void) updatePreviewCollectionView:(Song*)song;

// Accessor methods
- (NSTableView*) songsTableView;
- (NSTableView*) playlistTableView;

@end