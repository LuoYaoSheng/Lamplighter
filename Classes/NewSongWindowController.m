#import "NewSongWindowController.h"

#import "ApplicationDelegate.h"

@implementation NewSongWindowController

- (IBAction) newSong:(id)sender {
  self.titleErrors = YES;
  self.contentErrors = YES;
  // Resetting TextField values from former Song creations
  [titleField setStringValue:@""];
  [contentField setStringValue:@""];
  [copyrightField setStringValue:@""];
  //[self updateButtons:self];
  [self.window makeFirstResponder:titleField];
  [NSApp beginSheet:self.window modalForWindow:[[NSApp mainWindowController] window] modalDelegate:self didEndSelector:@selector(sheetEnded:returnCode:contextInfo:) contextInfo:NULL]; 
}

- (void) sheetEnded:(NSWindow*)sheet returnCode:(int)code contextInfo:(void*)context {
  NSLog(@"asdas");
}


@end
