#import "BaseView.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "LiveviewController.h"

@implementation BaseView

/* See comment at BaseWindow.
 */
- (void)cancelOperation:(id)sender {
  if (![[[NSApp mainWindowController] liveviewController] ensureNoSelection]) {
    [[self nextResponder] cancelOperation:sender];
  }
}

@end
