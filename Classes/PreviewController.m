#import "PreviewController.h"

#import "Presentation.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"

@implementation PreviewController

/***********************
 * NSTableViewDelegate *
 ***********************/

// This controller serves as delegate for Tables and thus implements the following
// method to keep track of selection changes in the Tables
- (void) tableViewSelectionDidChange:(NSNotification*)notification {
  // Getting the interplay of selections with all tables right if a song was actually selected
  if ([self exclusifyTableSelectionFor:[notification object]]) {
    
    // Determining the Array Controller of the selected table
    NSDictionary *tableContentBindingInfo = [[notification object] infoForBinding:NSContentBinding];
    if (tableContentBindingInfo != nil) {
      NSArrayController *tableArrayController = [tableContentBindingInfo objectForKey:NSObservedObjectKey];
      
      if ([notification object] == [self songsTableView] || [notification object] == [self playlistTableView]) {
        // Let's bind the Projector Slide
        Presentation *presentation = [[tableArrayController selectedObjects] lastObject];
        //[[NSApp projectorSlideController] setContent:[[song sortedSlides] objectAtIndex:0]];
        
        [self setPresentation:presentation];
      }
    }
  }
}



/********************
 * INSTANCE METHODS *
 ********************/

- (BOOL) exclusifyTableSelectionFor:(NSTableView*)table {
  // There is nothing selected in this table.
  if ([table selectedRow] < 0) return NO;
  
  // Let's see which table has been selected
  if (table == [self songsTableView]) {
    // A song in the songsTable has been selected
    // Let's deselect all selected objects in other tables
    [[self playlistTableView] setAllowsEmptySelection:YES];
    [[self playlistTableView] deselectAll:self];
    [[self playlistTableView] setAllowsEmptySelection:NO];
    
  } else if (table == [self playlistTableView]) {
    // A song in the playlist has been selected
    // Let's deselect all selected objects in other tables
    [[self songsTableView] setAllowsEmptySelection:YES];
    [[self songsTableView] deselectAll:self];
    [[self songsTableView] setAllowsEmptySelection:NO];

    //if ([[self songsTableView] selectedRow] >= 0) [[NSApp songsArrayController] setSelectionIndex:-1];
  }
  return YES;
}

- (void) setPresentation:(Presentation*)presentation {
  [[[NSApp mainWindowController] previewCollectionView] setContent:[presentation sortedSlides]];
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