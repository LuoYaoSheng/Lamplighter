#import "BaseWindow.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "LiveviewController.h"

@implementation BaseWindow


/* As you might or might not know, the Escape key is *firmly* bound to this NSResponder method. We cannot
 * use the bare Escape as a trigger for a NSMenuItem. However, we want the Escape key to do something for us.
 * Particularly, if the "ensureNoSelection" method returns YES (that means, it did have an effect), we're
 * content and don't call the cancelOperation of the next responder in the responder chain.
 */
- (void)cancelOperation:(id)sender {
  if (![[[NSApp mainWindowController] liveviewController] ensureNoSelection]) {
    [super cancelOperation:sender];
  }
}

@end