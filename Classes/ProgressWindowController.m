#import "ProgressWindowController.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"

@implementation ProgressWindowController

@synthesize progressIndicator;

- (void) setMaxValue:(NSUInteger)newValue {
  DLog(@"maximum value is %i", (int)newValue);
  //[self.progressIndicator setIndeterminate:NO];
  [self.progressIndicator setMaxValue:(double)newValue];
}

- (void) progressDidChangeNotification: (NSNotification*)notification  {
  [self setProgressValue:[[[notification userInfo] valueForKey:@"progress"] doubleValue]];
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
  DLog(@"sheetEnded");
  [sheet orderOut:nil];
}

@end
