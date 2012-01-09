#import "Importer.h"

@class SongsArrayController;
@class ProgressWindowController;

@interface SongImporter : Importer {

  NSString *filepath;
  NSXMLDocument *document;
  
  // Array Controllers
  SongsArrayController *songsArrayController;

}

@property (nonatomic, readwrite) NSString *filepath;
@property (nonatomic, strong, readwrite) NSXMLDocument *document;

@property (nonatomic, readonly) SongsArrayController *songsArrayController;

- (id) initWithPath:(NSString*)newFilepath;
- (void) import;
- (void) importEasislidesStarter:sender;
- (void) importEasislides;
- (void) addSong:(NSString*)title withContent:(NSString*)content andFootnote:(NSString*)footnote;
- (id) managedObjectContextForThread;

@end
