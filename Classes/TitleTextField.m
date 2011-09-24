#import "TitleTextField.h"
#import "Presentation.h"

@implementation TitleTextField

- (void) textDidEndEditing:(NSNotification*)notification {
  [self setStringValue:[Presentation normalizeTitle:[self stringValue]]];
  [super textDidEndEditing: notification];
}

@end
