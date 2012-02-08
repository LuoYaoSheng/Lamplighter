#import "PDF.h"

@implementation PDF

@synthesize url;

/********************
 * INSTANCE METHODS *
 ********************/

- (NSString*) title {
  return [url.lastPathComponent stringByDeletingPathExtension];;
}

- (void) setTitle:(NSString*)newTitle {
}

- (void) prepareForDeletion {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;
  [fileManager removeItemAtURL:self.url error:&error];
}

@end