#import "PDFImporter.h"

#import "ApplicationDelegate.h"
#import "ProgressWindowController.h"
#import "PDFsArrayController.h"

@implementation PDFImporter

@synthesize paths;

- (id) initWithPaths:(NSArray*)newPaths {
  [[self progressWindowController] show];
  self.paths = newPaths;
  return self;
}

- (BOOL) import {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSUInteger totalCount = [self.paths count];

  int i = 1;
  for (NSString *source in self.paths) {
    float progress = ((float)i / totalCount) * 100;
    
    NSError *error = nil;
    NSString *target = [[NSApp pdfsDirectoryPath] stringByAppendingPathComponent:[source lastPathComponent]];
    
    CFStringRef fileExtension = (__bridge CFStringRef) [source pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);

    if (UTTypeConformsTo(fileUTI, kUTTypePDF) && ![fileManager contentsEqualAtPath:source andPath:target]) {
      if ([fileManager fileExistsAtPath:target]) [fileManager removeItemAtPath:target error:&error];
      if (error) NSLog(@"Error when removing existing file: %@", error);
      DLog(@"Importing PDF %@", source);
      [fileManager copyItemAtPath:source toPath:target error:&error];
      if (error) NSLog(@"Error when importing PDF: %@", error);
    }
    [self setProgress:progress];

    CFRelease(fileUTI);
    i++;
  }
  
  [[self progressWindowController] orderOut];
  [[NSApp pdfsArrayController] update];
  return YES;
}

@end
