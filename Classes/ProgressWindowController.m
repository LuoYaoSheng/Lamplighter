#import "ProgressWindowController.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"

@implementation ProgressWindowController

@synthesize progressIndicator;

- (void) setMaxValue:(NSUInteger)newValue {
  debugLog(@"maximum value is %i", newValue);
  //[self.progressIndicator setIndeterminate:NO];
  [self.progressIndicator setMaxValue:(double)newValue];
}

- (void) setProgressValue:(double)newValue {
  [self.progressIndicator setDoubleValue:newValue];
}

- (void) show {
  //[self.progressIndicator setIndeterminate:YES];
  [NSApp beginSheet:self.window modalForWindow:[[NSApp mainWindowController] window] modalDelegate:self didEndSelector:@selector(sheetEnded:returnCode:contextInfo:) contextInfo:NULL];  
}

- (void) orderOut {
  [NSApp endSheet:self.window returnCode:NSOKButton];
}

- (void) sheetEnded:(NSWindow*)sheet returnCode:(int)code contextInfo:(void*)context {
  debugLog(@"sheetEnded");
  [sheet orderOut:nil];
}

@end
