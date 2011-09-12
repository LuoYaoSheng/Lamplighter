#import "SongWindowController.h"

@implementation SongWindowController

@synthesize titleErrors, contentErrors;

- (void) updateButtons:(id)sender {
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
