@class Presentation;

@interface LiveviewController : NSObject {
  
}

- (void) setPresentation:(Presentation*)presentation andIndex:(NSUInteger)index;
- (BOOL) ensureNoSelection;

@end