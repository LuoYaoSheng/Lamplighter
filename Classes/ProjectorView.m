#import "ProjectorView.h"

@implementation ProjectorView

/* The background NSView of the Projector is an instance of this class.
 * We want it to be black so that when one slide is replaced by the other,
 * nobody will see the screen flashing up light for a millisecond.
 */
- (void) drawRect:(NSRect)rect {
  [[NSColor blackColor] set];
  [NSBezierPath fillRect: [self bounds]];
}

@end
