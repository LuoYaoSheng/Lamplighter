#import "BaseArrayController.h"

@implementation BaseArrayController

- (id) init {
  self = [super init];
  if (self) {
    [self setAvoidsEmptySelection:NO];
  }
  return self;
}

/* The Core Data documentation says:
 *
 * "... It is important to note that the controller's fetch is executed as a delayed operation
 * "performed after its managed object context is set (by nib loading) — this therefore happens
 * after awakeFromNib and windowControllerDidLoadNib:. This can create a problem if you want to
 * perform an operation with the contents of an object controller in either of these methods,
 * since the controller's content is nil. You can work around this by executing the fetch "manually".
 *
 * This is what we do here. Whoever wants to access the controller's data, needs to call this method
 * first. It ensures that the initial content loading has actually taken place. Note that this is
 * not happening automatically, because we don't want to waste resources on application launch. It
 * should really just be loaded when it's needed (e.g. when a drawer with the content is opened).
 */
- (void) ensureContentIsLoaded {
  NSError *error = nil;
  [self fetchWithRequest:nil merge:NO error:&error];
}

@end
