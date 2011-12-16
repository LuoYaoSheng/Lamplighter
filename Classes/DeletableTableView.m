#import "DeletableTableView.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"

@implementation DeletableTableView

- (void) keyDown:(NSEvent*)event {
  NSString *chars = [event characters];
  unichar character = [chars characterAtIndex: 0];
  NSInteger flags = ([event modifierFlags] & NSDeviceIndependentModifierFlagsMask);
  
  if (character == NSDeleteCharacter) {
    if (flags == NSCommandKeyMask) {
      [self deleteSelectedItem];
    } else {
      [self areYouSure];
    }
  } else {
    [super keyDown:event];
  }
}

- (void) areYouSure {
  NSString *question = NSLocalizedString(@"general.are_you_sure", nil);
  NSString *info = [self warningMessage];
  NSString *quitButton = NSLocalizedString(@"general.ok", nil);
  NSString *cancelButton = NSLocalizedString(@"general.cancel", nil);
  NSAlert *alert = [[NSAlert alloc] init];
  [alert setAlertStyle:NSWarningAlertStyle];
  [alert setMessageText:question];
  [alert setInformativeText:info];
  [alert addButtonWithTitle:quitButton];
  [alert addButtonWithTitle:cancelButton];
  [alert beginSheetModalForWindow:[[NSApp mainWindowController] window] modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void) alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)code contextInfo:(void *)context {
  if (code == NSAlertFirstButtonReturn) [self deleteSelectedItem];
}

- (void) deleteSelectedItem {
  // Implemented by subclasses
}

- (NSString*) warningMessage {
  return @"Implemented by subclasses";
}

@end
