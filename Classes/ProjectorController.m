#import "ProjectorController.h"

#import "ProjectorWindowController.h"
#import "Song.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"

@implementation ProjectorController

/**********************
 * WINDOW CONTROLLERS *
 **********************/

- (ProjectorWindowController*) projectorWindowController {
  if (projectorWindowController) return projectorWindowController;
	projectorWindowController = [[ProjectorWindowController alloc] initWithWindowNibName:@"ProjectorWindow"];
  return projectorWindowController;
}



/********************
 * ACCESSOR METHODS *
 ********************/

- (NSTableView*) songsTableView {
  return [[[NSApp mainWindowController] songsDrawerViewController] songsTableView];
}

- (NSTableView*) playlistTableView {
  return [[NSApp mainWindowController] playlistTableView];
}

@end