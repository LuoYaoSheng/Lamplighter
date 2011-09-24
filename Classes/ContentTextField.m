#import "ContentTextField.h"
#import "Song.h"

@implementation ContentTextField

- (void) textDidEndEditing:(NSNotification*)notification {
  [self setStringValue:[Presentation normalizeContent:[self stringValue]]];
  [super textDidEndEditing: notification];
}

@end
