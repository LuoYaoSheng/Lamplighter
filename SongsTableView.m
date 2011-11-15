#import "SongsTableView.h"

#import "Song.h"

@implementation SongsTableView

- (void) keyDown:(NSEvent*)event {
  NSString *chars = [event characters];
  unichar character = [chars characterAtIndex: 0];
  NSInteger flags = ([event modifierFlags] & NSDeviceIndependentModifierFlagsMask);

  if (character == NSDeleteCharacter) {
    if (flags == NSCommandKeyMask) {
      [self deleteSelectedSong:YES]; // Force delete
    } else {
      [self deleteSelectedSong:NO];
    }
  } else {
    [super keyDown:event];
  }
}

- (void) deleteSelectedSong:(BOOL)force {
  NSUInteger firstSelectedRow = [[self selectedRowIndexes] firstIndex];
  [[NSApp songsArrayController] remove:self];
  [[NSApp songsArrayController] setSelectionIndex:firstSelectedRow];
  
}

- (void) deleteSong:(Song*)song {
  
}

- (NSDragOperation) draggingSourceOperationMaskForLocal:(BOOL)flag {
  return NSDragOperationCopy;
}

@end
