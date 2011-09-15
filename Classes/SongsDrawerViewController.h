@class SongsTableDataSource;

@interface SongsDrawerViewController : NSViewController {

  IBOutlet NSTableColumn *tableColumn;
  IBOutlet NSTableView *tableView;
  IBOutlet NSButton *newSongButton;
  
  // Data Sources
  SongsTableDataSource *songsTableDataSource;
}

// GUI Items
@property (nonatomic, retain) IBOutlet NSTableColumn *tableColumn;
@property (nonatomic, retain, readonly) IBOutlet NSTableView *tableView;
@property (nonatomic, retain, readonly) IBOutlet NSButton *newSongButton;

// Data Sources
@property (nonatomic, retain, readonly) SongsTableDataSource *songsTableDataSource;

// New Song
- (IBAction) newSong:sender;


@end
