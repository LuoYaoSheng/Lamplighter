@class SongsTableDataSource;

@interface SongsDrawerViewController : NSViewController {

  IBOutlet NSTableColumn *tableColumn;
  IBOutlet NSButton *newSongButton;
  
  // Data Sources
  SongsTableDataSource *songsTableDataSource;
}

// GUI Items
@property (nonatomic, retain, readonly) IBOutlet NSTableColumn *tableColumn;
@property (nonatomic, retain, readonly) IBOutlet NSButton *newSongButton;

// Data Sources
@property (nonatomic, retain, readonly) SongsTableDataSource *songsTableDataSource;

// New Song
- (IBAction) newSong:(id)sender;


@end
