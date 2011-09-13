#import "Slide.h"

#import "Presentation.h"

@implementation Slide 

@dynamic content;
@dynamic position;
@dynamic presentation;

- (int) numberOfLines {
  return [[[self content] componentsSeparatedByString: @"\n"] length];
}

@end
