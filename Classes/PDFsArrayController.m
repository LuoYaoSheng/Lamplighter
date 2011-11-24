#import "PDFsArrayController.h"

#import "PDF.h"

@implementation PDFsArrayController

- (id) init {
  debugLog(@"[PDFsArrayController] init");
  self = [super init];
  return self;
}

- (void) update {
  [NSApp ensurePDFsDirectory];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error = nil;
  NSArray *urls = [fileManager contentsOfDirectoryAtURL:[NSApp pdfsDirectoryURL] includingPropertiesForKeys:NULL options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];

  for (NSURL *url in urls) {
    if (![[self arrangedObjects] containsObject:url]) [self addObject:url];
  }
  
  for (NSURL *url in [self arrangedObjects]) {
    if (![urls containsObject:url]) [self removeObject:url];
  }  
}


@end
