@class Presentation; 
@class PDF;

@interface PreviewController : NSObject <NSTableViewDelegate, NSCollectionViewDelegate> {
  
}

// Instance methods
- (BOOL) exclusifyTableSelectionFor:(NSTableView*)table;
- (void) setPresentation:(Presentation*)presentation;
- (void) setPDF:(PDF*)pdf;

// Accessor methods
- (NSTableView*) songsTableView;
- (NSTableView*) playlistTableView;

@end