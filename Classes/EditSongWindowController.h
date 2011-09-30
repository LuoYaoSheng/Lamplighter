#import "SongWindowController.h"

@interface EditSongWindowController : SongWindowController {

}

- (void) setupTextFieldBindings;

- (IBAction) editSong:sender;
- (IBAction) doneEditSong:sender;

@end