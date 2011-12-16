#import "PDFsTableView.h"

@implementation PDFsTableView

- (void) deleteSelectedItem {
  debugLog(@"Deleting selected PDF.");
}


- (NSString*) warningMessage {
  return NSLocalizedString(@"pdf.warning.delete", nil);
}

@end
