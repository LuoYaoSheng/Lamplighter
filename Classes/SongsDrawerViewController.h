@class SongsTableDataSource;

@interface SongsDrawerViewController : NSViewController {

  IBOutlet NSTableColumn *songsTableColumn;
  IBOutlet NSTableView *songsTableView;
  IBOutlet NSButton *newSongButton;
  
  // Data Sources
  SongsTableDataSource *songsTableDataSource;
}

// GUI Items
@property (nonatomic, retain) IBOutlet NSTableColumn *songsTableColumn;
@property (nonatomic, retain, readonly) IBOutlet NSTableView *songsTableView;
@property (nonatomic, retain, readonly) IBOutlet NSButton *newSongButton;

// Data Sources
@property (nonatomic, retain, readonly) SongsTableDataSource *songsTableDataSource;

- (void) setupSongsTable;

// New Song
- (IBAction) newSong:sender;


@end
