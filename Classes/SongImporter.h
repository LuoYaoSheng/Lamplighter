@class SongsArrayController;

@interface SongImporter : NSObject {

  NSString *filepath;
  NSXMLDocument *document;
  
  // Array Controllers
  SongsArrayController *songsArrayController;

}

@property (nonatomic, retain, readwrite) NSString *filepath;
@property (nonatomic, retain, readwrite) NSXMLDocument *document;

@property (nonatomic, retain, readonly) SongsArrayController *songsArrayController;

- (void) import;

@end
