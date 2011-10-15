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

/**************
 * PROPERTIES *
 **************/

@property (readwrite) BOOL titleErrors;
@property (readwrite) BOOL contentErrors;

/***********
 * METHODS *
 ***********/

- (void) updateButtons;

@end
