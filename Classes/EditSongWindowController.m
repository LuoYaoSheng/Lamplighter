#import "EditSongWindowController.h"

#import "ApplicationDelegate.h"
#import "Song.h"
#import "PreviewController.h"
#import "MainWindowController.h"

@implementation EditSongWindowController

/******************
 * INITIALIZATION *
 ******************/

- (void) awakeFromNib {
  [super awakeFromNib];
  [self setupTextFieldBindings];
}

- (void) setupTextFieldBindings {
  [titleField bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.title" options:nil];
  [contentField bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.content" options:nil];
  [copyrightField bind:NSValueBinding toObject:[NSApp songsArrayController] withKeyPath:@"selection.footnote" options:nil];
}

/********************
 * INSTANCE METHODS *
 ********************/

- (IBAction) editSong:sender {
  self.titleErrors = NO;
  self.contentErrors = NO;
  [self updateButtons];
  [self.window makeFirstResponder:titleField];

  [NSApp beginSheet:self.window modalForWindow:[[NSApp mainWindowController] window] modalDelegate:self didEndSelector:@selector(sheetEnded:returnCode:contextInfo:) contextInfo:NULL]; 
}

- (void) doneEditSong:sender {
  // The cursor is still in a text field at this point. The Core Data object will not be saved
  // until the cursor has left the textfield. That's why we do that here.
  [self.window makeFirstResponder:doneButton];
  [NSApp endSheet:self.window returnCode:NSOKButton];
}

@end
