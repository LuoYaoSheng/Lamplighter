@class PDFsTableDataSource;

@interface PDFsDrawerViewController : NSViewController {

  IBOutlet NSTableColumn *tableColumn;
  IBOutlet NSTableView *tableView;
  
  // Data Sources
  PDFsTableDataSource *pdfsTableDataSource;
}

/**************
 * PROPERTIES *
 **************/

// GUI Items
@property (nonatomic, retain) IBOutlet NSTableColumn *tableColumn;
@property (nonatomic, retain, readonly) IBOutlet NSTableView *tableView;

// Data Sources
@property (nonatomic, retain, readonly) PDFsTableDataSource *pdfsTableDataSource;

/***********
 * METHODS *
 ***********/

// Initialization
- (void) setupTableView;

@end