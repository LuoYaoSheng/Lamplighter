#import "SongWindowController.h"

#import "Song.h"

@implementation SongWindowController

@synthesize titleErrors, contentErrors;

/************************
 * NSTextFieldDelegator *
 ************************/

- (BOOL) control:(NSControl*)control textView:(NSTextView*)textView doCommandBySelector:(SEL)commandSelector {
  BOOL result = NO;
  // new line action of the content textfield:
  if ((control == contentField) && commandSelector == @selector(insertNewline:)) {
    // always insert a line-break character and don’t cause the receiver to end editing
    [textView insertNewlineIgnoringFieldEditor:self];
    result = YES;
  }
  return result;
}

/**************
 * VALIDATION *
 **************/

/*
 * We are the delegate of all text fields in the new song form. On every keystroke
 * we perform a validation.
 */
- (void) controlTextDidChange:(NSNotification*)notification {
  if ([notification object] == titleField) {
    titleErrors = ![Song validTitle:[[notification object] stringValue]];
  } else if ([notification object] == contentField) {
    contentErrors = ![Song validTitle:[[notification object] stringValue]];
  }
  [self updateButtons];
}

/*
 * Enable or disable the save button whenever all TextFields have valid values.
 */
- (void) updateButtons {
  if (!titleErrors && !contentErrors) {
    // We don't care to check whether we're creating or editing a song.
    // Just enabling/disabling all existing buttons is efficient enough.
    [saveButton setEnabled:YES];
    [doneButton setEnabled:YES];
  } else {
    [saveButton setEnabled:NO];
    [doneButton setEnabled:NO];
  }
}

/*************
 * CALLBACKS *
 *************/

- (void) sheetEnded:(NSWindow*)sheet returnCode:(int)code contextInfo:(void*)context {
  [sheet orderOut:nil];
}

/**********************
 * GUI INITIALIZATION *
 **********************/

- (void) awakeFromNib {
  // I18n
  [[titleField cell] setPlaceholderString:NSLocalizedString(@"song.form.title.placeholder", nil)];
  [[contentField cell] setPlaceholderString:NSLocalizedString(@"song.form.content.placeholder", nil)];
  [[copyrightField cell] setPlaceholderString:NSLocalizedString(@"song.form.copyright.placeholder", nil)];
  [cancelButton setTitle:NSLocalizedString(@"general.cancel", nil)];
  [saveButton setTitle:NSLocalizedString(@"general.save", nil)];
  [doneButton setTitle:NSLocalizedString(@"general.done", nil)];
}

@end
