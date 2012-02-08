#import "PDFsTableView.h"

@implementation PDFsTableView

- (void) deleteSelectedItem {
  DLog(@"Deleting selected PDF.");
}


- (NSString*) warningMessage {
  return NSLocalizedString(@"pdf.warning.delete", nil);
}

@end
