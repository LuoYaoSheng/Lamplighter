#import "PreviewCollectionView.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "LiveviewController.h"

@implementation PreviewCollectionView

- (void) afterSelectionChanged {
  //[[[NSApp mainWindowController] liveviewController] setPresentation:[self presentation] andIndex:[self selectionIndex]];
}

@end