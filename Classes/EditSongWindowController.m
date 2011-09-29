#import "EditSongWindowController.h"

#import "ApplicationDelegate.h"
#import "Song.h"

@implementation EditSongWindowController

/********************
 * INSTANCE METHODS *
 ********************/

- (IBAction) editSong:sender {
  self.titleErrors = NO;
  self.contentErrors = NO;
  [titleField bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.title" options:nil];
  [contentField bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.content" options:nil];
  [copyrightField bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.footnote" options:nil];
  [self updateButtons];
  [self.window makeFirstResponder:titleField];
  [NSApp beginSheet:self.window modalForWindow:[[NSApp mainWindowController] window] modalDelegate:self didEndSelector:@selector(sheetEnded:returnCode:contextInfo:) contextInfo:NULL]; 
}

- (IBAction) doneEditSong:sender {
  [NSApp endSheet:self.window returnCode:NSOKButton];
}

/*************
 * CALLBACKS *
 *************/

- (void) sheetEnded:(NSWindow*)sheet returnCode:(int)code contextInfo:(void*)context {
  [sheet orderOut:nil];
}

@end
