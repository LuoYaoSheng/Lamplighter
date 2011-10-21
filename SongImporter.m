#import "SongImporter.h"

#import "Song.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "ProgressWindowController.h"

@implementation SongImporter

@synthesize filepath, document;

- (id) initWithPath:(NSString*)newFilepath {
  [[self progressWindowController] show];
  self.filepath = newFilepath;
  return self;
}

- (void) import {
  NSError *error = nil;
  NSData *data = [[NSData alloc] initWithContentsOfFile:self.filepath options:0 error:&error];
  self.document = [[NSXMLDocument alloc] initWithData:data options:0 error:&error];
  NSString *rootName = [[self.document rootElement] name];
  if ([rootName isEqualToString:@"EasiSlides"]) {
    [self importEasislides];
  }
}

- (void) importEasislides {
  debugLog(@"Importing: %@", [[self.document rootElement] name]);
  NSUInteger songsCount = [[self.document rootElement] childCount];
  
  int i = 1;
  for (NSXMLElement* element in [[self.document rootElement] children]) {
    float progress = ((float)i / songsCount) * 100;
    
    //debugLog(@"element: %@", [[element children] objectAtIndex:0]);
    
    NSString *title    = [[[element elementsForName:@"Title1"] objectAtIndex:0] stringValue];
    NSString *content  = [[[element elementsForName:@"Contents"] objectAtIndex:0] stringValue];
    NSString *footnote = [[[element elementsForName:@"Writer"] objectAtIndex:0] stringValue];
    
    NSString *copyright = [[[element elementsForName:@"Copyright"] objectAtIndex:0] stringValue];
    NSString *license1  = [[[element elementsForName:@"LicenceAdmin1"] objectAtIndex:0] stringValue];
    NSString *license2  = [[[element elementsForName:@"LicenceAdmin2"] objectAtIndex:0] stringValue];
    
    if (![copyright isEqualToString:@""]) footnote = [footnote stringByAppendingFormat:@", %@", copyright];
    if (![license1 isEqualToString:@""]) footnote = [footnote stringByAppendingFormat:@", %@", license1];
    if (![license2 isEqualToString:@""]) footnote = [footnote stringByAppendingFormat:@", %@", license2];
    
    [self addSong:title withContent:content andFootnote:footnote];
    
    [[self progressWindowController] setProgressValue:progress];
    
    i++;
    //if (i >= 1) break;
  }
  
  [[self progressWindowController] orderOut];
}

- (void) addSong:(NSString*)title withContent:(NSString*)content andFootnote:(NSString*)footnote {
  Song *song = [[NSApp songsArrayController] newObject];
  [song setValue:title forKey:@"title"];
  [song setValue:content forKey:@"content"];
  [song setValue:footnote forKey:@"footnote"];
  [[NSApp songsArrayController] addObject:song];
}

/********************
 * ACCESSOR METHODS *
 ********************/

- (ProgressWindowController*) progressWindowController {
  return [[NSApp mainWindowController] progressWindowController];
}

@end
