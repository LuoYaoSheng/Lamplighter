@interface PreviewController : NSObject <NSTableViewDelegate> {
  
}

- (BOOL) exclusiveTableSelectionFor:(NSTableView*)table;

- (NSTableView*) songsTableView;
- (NSTableView*) playlistTableView;

@end