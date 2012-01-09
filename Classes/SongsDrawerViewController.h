@class SongsTableDataSource;

@interface SongsDrawerViewController : NSViewController {

  IBOutlet NSTableColumn *songsTableColumn;
  IBOutlet NSTableView *songsTableView;
  IBOutlet NSButton *createSongButton;
  IBOutlet NSSearchField *searchField;
  
  // Data Sources
  SongsTableDataSource *songsTableDataSource;
}

/**************
 * PROPERTIES *
 **************/

// GUI Items
@property (nonatomic) IBOutlet NSTableColumn *songsTableColumn;
@property (nonatomic, readonly) IBOutlet NSTableView *songsTableView;
@property (nonatomic, readonly) IBOutlet NSButton *createSongButton;
@property (nonatomic, readonly) IBOutlet NSSearchField *searchField;

// Data Sources
@property (nonatomic, readonly) SongsTableDataSource *songsTableDataSource;

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