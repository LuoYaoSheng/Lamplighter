#import "LiveviewController.h"

#import "Presentation.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "LiveviewController.h"

@implementation LiveviewController

- (void) setPresentation:(Presentation*)presentation andIndex:(NSUInteger)index {
  [[[NSApp mainWindowController] liveviewCollectionView] setPresentation:presentation andIndex:index];
}

@end