@class Presentation; 

@interface PreviewController : NSObject <NSTableViewDelegate, NSCollectionViewDelegate> {
  
}

// Instance methods
- (BOOL) exclusifyTableSelectionFor:(NSTableView*)table;
- (void) setPresentation:(Presentation*)presentation;

// Accessor methods
- (NSTableView*) songsTableView;
- (NSTableView*) playlistTableView;

@end