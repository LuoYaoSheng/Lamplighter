@interface SongWindowController : NSWindowController {

  BOOL titleErrors;
  BOOL contentErrors;

  // New Song Form
  IBOutlet NSTextField *titleField;
  IBOutlet NSTextField *contentField;
  IBOutlet NSTextField *copyrightField;
  IBOutlet NSButton *cancelButton;
  IBOutlet NSButton *saveButton;
  IBOutlet NSButton *doneButton;

}

@property (readwrite) BOOL titleErrors;
@property (readwrite) BOOL contentErrors;

- (void) updateButtons:(id)sender;

@end
