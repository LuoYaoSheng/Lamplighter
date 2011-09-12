@class SongsTableDataSource;

@interface SongsDrawerViewController : NSViewController {

  IBOutlet NSTableColumn *tableColumn;
  
  // Data Sources
  SongsTableDataSource *songsTableDataSource;
}

@property (nonatomic, retain) IBOutlet NSTableColumn *tableColumn;

// Data Sources
@property (nonatomic, retain, readonly) SongsTableDataSource *songsTableDataSource;


@end
