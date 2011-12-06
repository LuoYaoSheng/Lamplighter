@class SongsArrayController;
@class ProgressWindowController;

@interface SongImporter : NSObject {

  NSString *filepath;
  NSXMLDocument *document;
  
  // Array Controllers
  SongsArrayController *songsArrayController;

}

@property (nonatomic, retain, readwrite) NSString *filepath;
@property (nonatomic, retain, readwrite) NSXMLDocument *document;

@property (nonatomic, retain, readonly) SongsArrayController *songsArrayController;

- (id) initWithPath:(NSString*)newFilepath;
- (void) import;
- (void) importEasislidesStarter:sender;
- (void) importEasislides;
- (void) addSong:(NSString*)title withContent:(NSString*)content andFootnote:(NSString*)footnote;
- (id) managedObjectContextForThread;

- (ProgressWindowController*) progressWindowController;

@end
