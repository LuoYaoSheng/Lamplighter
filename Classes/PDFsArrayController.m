#import "PDFsArrayController.h"

#import "ApplicationDelegate.h"
#import "PDF.h"

@implementation PDFsArrayController

- (id) init {
  self = [super init];
  if (self) {
    [self setAutomaticallyRearrangesObjects:YES];
    [self setAutomaticallyPreparesContent:YES];
    [self setEntityName:@"PDF"];
  }
  return self;
}

- (void) update {
  [NSApp ensurePDFsDirectory];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error = nil;
  NSArray *urls = [fileManager contentsOfDirectoryAtURL:[NSApp pdfsDirectoryURL] includingPropertiesForKeys:NULL options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];

  for (NSURL *url in urls) {
    if ([[self PDFsWithURL:url] count] == 0) {
      CFStringRef fileExtension = (__bridge CFStringRef) [url pathExtension];
      CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
      
      if (UTTypeConformsTo(fileUTI, kUTTypePDF)) {
        PDF *pdf = [self newObject];
        pdf.url = url;
        if (![[self arrangedObjects] containsObject:url]) [self addObject:pdf];
      }
      CFRelease(fileUTI);
    }
  }
  
  for (PDF *pdf in [self arrangedObjects]) {
    if (![urls containsObject:pdf.url]) [self removeObject:pdf];
  }
  [[NSApp managedObjectContext] commitEditing];
}

- (NSArray*) PDFsWithURL:(NSURL*)url {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@", url];
  return [[self arrangedObjects] filteredArrayUsingPredicate:predicate];
}

@end