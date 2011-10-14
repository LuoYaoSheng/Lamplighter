@class Presentation;
@class Slide;

@interface BaseCollectionView : NSCollectionView {

}

// Setter Methods
- (void) setPresentation:(Presentation*)presentation;
- (void) setPresentation:(Presentation*)presentation andIndex:(NSUInteger)index;
- (void) setSelectionIndexes:(NSIndexSet*)indexes;
- (void) setSelectionIndex:(NSUInteger)index;

// Hooks
- (void) afterSelectionChanged;
- (void) sendSelectionDidChangeNotification;

// Getter Methods
- (Presentation*) presentation;
- (Slide*) selectedSlide;
- (NSUInteger) selectionIndex;

@end
