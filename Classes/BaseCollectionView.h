@class Presentation;
@class Slide;

@interface BaseCollectionView : NSCollectionView {

}

// Item handling
- (void) updateThumbnailSize;
- (void) resizePreviewSlidesAccordingTo:(NSSize)size;
- (void) setContent:(id)newContent andIndex:(NSUInteger)index;

// Selection handling
- (BOOL) deselectAll;
- (void) setSelectionIndexes:(NSIndexSet*)indexes;

@end
