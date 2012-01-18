#import "BaseWindow.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "LiveviewController.h"
#import "ProjectorController.h"

@implementation BaseWindow


/* As you might or might not know, the Escape key is *firmly* bound to this NSResponder method. We cannot
 * use the bare Escape as a trigger for a NSMenuItem. However, we want the Escape key to do something for us.
 * Particularly, if the "ensureNoSelection" method returns YES (that means, it did have an effect), we're
 * content and don't call the cancelOperation of the next responder in the responder chain.
 */
- (void) cancelOperation:sender {
  // If we're showing a PDF, catch the escape key and show a blank screen.
  if ([[NSApp projectorController] showsPDF]) {
    [[NSApp projectorController] goBlank];
    return;
  // If we're showing a Slide, catch the escape key deselect it in the Thumbnailview 
  } else if ([[NSApp projectorController] showsSlide] && [[[NSApp mainWindowController] liveviewController] ensureNoSelection]) {
    return;  
  }
  // Other than that we don't catch the operation and push it up in the responder chain
  [super cancelOperation:sender];
}

@end