#import "Importer.h"

@interface PDFImporter : Importer {

  NSArray *paths;
  
}

@property (nonatomic, retain, readwrite) NSArray *paths;

- (id) initWithPaths:(NSArray*)newPaths;
- (BOOL) import;

@end
