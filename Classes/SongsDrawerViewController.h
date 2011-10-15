@class SongsTableDataSource;

@interface SongsDrawerViewController : NSViewController {

  IBOutlet NSTableColumn *songsTableColumn;
  IBOutlet NSTableView *songsTableView;
  IBOutlet NSButton *newSongButton;
  IBOutlet NSSearchField *searchField;
  
  // Data Sources
  SongsTableDataSource *songsTableDataSource;
}

/**************
 * PROPERTIES *
 **************/

// GUI Items
@property (nonatomic, retain) IBOutlet NSTableColumn *songsTableColumn;
@property (nonatomic, retain, readonly) IBOutlet NSTableView *songsTableView;
@property (nonatomic, retain, readonly) IBOutlet NSButton *newSongButton;
@property (nonatomic, retain, readonly) IBOutlet NSSearchField *searchField;

// Data Sources
@property (nonatomic, retain, readonly) SongsTableDataSource *songsTableDataSource;

/***********
 * METHODS *
 ***********/

// Initialization
- (void) setupSongsTable;

// GUI Actions
- (IBAction) songsTableViewDoubleClicked:sender;
- (IBAction) newSong:sender;
- (IBAction)filterSongs:sender;

@end