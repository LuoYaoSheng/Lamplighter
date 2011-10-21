#import <Cocoa/Cocoa.h>

@interface SongImporter : NSObject {

  NSString *filepath;
  NSXMLDocument *document;
  
}

@property (nonatomic, retain, readwrite) NSString *filepath;
@property (nonatomic, retain, readwrite) NSXMLDocument *document;

- (void) import;

@end
