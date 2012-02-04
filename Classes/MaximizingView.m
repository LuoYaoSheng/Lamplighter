#import "MaximizingView.h"

@implementation MaximizingView

- (id)initWithFrame:(NSRect)frame {
NSLog(@"becoming alive");
  self = [super initWithFrame:frame];
  if (self) {
    [self setAutoresizingMask:(NSViewMinXMargin|NSViewWidthSizable|NSViewMaxXMargin|NSViewMinYMargin|NSViewHeightSizable|NSViewMaxYMargin)];
    [self setFrame:NSMakeRect(0, 0, self.superview.frame.size.width, self.superview.frame.size.height)];
  }
  return self;
}

//- (void)drawRect:(NSRect)dirtyRect {
  // Drawing code here.
//}

@end
