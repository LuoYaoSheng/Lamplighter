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
@property (nonatomic) IBOutlet NSTableColumn *tableColumn;
@property (nonatomic, readonly) IBOutlet NSTableView *tableView;

// Data Sources
@property (nonatomic, readonly) PDFsTableDataSource *pdfsTableDataSource;

/***********
 * METHODS *
 ***********/

// Initialization
- (void) setupTableView;

@end