#import "SongImporter.h"

#import "Song.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "ProgressWindowController.h"
#import "SongsArrayController.h"

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
    debugLog(@"forking");
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(importEasislidesStarter:) object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:[self progressWindowController] selector:@selector(progressDidChangeNotification:) name:ProgressDidChangeNotification object:nil];

    
    debugLog(@"Starting...");
    [thread start];
    
    /*
    while ([thread isExecuting]) {
      debugLog(@"Executing...");
      sleep(1);
    }
     */
    
    debugLog(@"Finished...");
    
    //[self importEasislides];
    
    
  }
}

- (void) importEasislidesStarter:sender {
  debugLog(@"importEasislidesStarter called");
  // This AutoreleasePool is mandatory for every Thread. Basically, it prevents
  // the code between here and "[pool drain]" to blow your memory into pieces.
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  [self importEasislides];
  
  
  
  [pool drain];
}

- (void) importEasislides {
  debugLog(@"Importing: %@", [[self.document rootElement] name]);
  NSUInteger songsCount = [[self.document rootElement] childCount];
  
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  
  int i = 1;
  for (NSXMLElement* element in [[self.document rootElement] children]) {
    float progress = ((float)i / songsCount) * 100;
    
    debugLog(@"element: %@", [[element children] objectAtIndex:0]);
    
    NSString *title    = [[[element elementsForName:@"Title1"] objectAtIndex:0] stringValue];
    NSString *content  = [[[element elementsForName:@"Contents"] objectAtIndex:0] stringValue];
    NSString *footnote = [[[element elementsForName:@"Writer"] objectAtIndex:0] stringValue];
    
    NSString *copyright = [[[element elementsForName:@"Copyright"] objectAtIndex:0] stringValue];
    NSString *license1  = [[[element elementsForName:@"LicenceAdmin1"] objectAtIndex:0] stringValue];
    NSString *license2  = [[[element elementsForName:@"LicenceAdmin2"] objectAtIndex:0] stringValue];
    
    if (![copyright isEqualToString:@""]) footnote = [footnote stringByAppendingFormat:@", %@", copyright];
    if (![license1 isEqualToString:@""]) footnote = [footnote stringByAppendingFormat:@", %@", license1];
    if (![license2 isEqualToString:@""]) footnote = [footnote stringByAppendingFormat:@", %@", license2];
    
    debugLog(@"addsong start...");

    [self addSong:title withContent:content andFootnote:footnote];

    //debugLog(@"addsong stop...");

    [dict setValue:[NSNumber numberWithFloat:progress] forKey:@"progress"];

    [[NSNotificationCenter defaultCenter] postNotificationName:ProgressDidChangeNotification object:self userInfo:dict];

    
    
    i++;
    if (i >= 100) break;
  }
  debugLog(@"finished.");

  [[self progressWindowController] orderOut];
}

- (void) addSong:(NSString*)title withContent:(NSString*)content andFootnote:(NSString*)footnote {
  //debugLog(@"adding song!");
  Song *song = [[NSApp songsArrayController] newObject];
  [song setValue:title forKey:@"title"];
  [song setValue:content forKey:@"content"];
  [song setValue:footnote forKey:@"footnote"];
  //debugLog(@"before array %@", NSApp);
  debugLog(@"before array %@", [NSApp songsArrayController]);
  [[self songsArrayController] addObject:song];
  debugLog(@"commiting");
  [[NSApp managedObjectContext] commitEditing];
  debugLog(@"after array");
}

- (id) managedObjectContextForThread; {    
  NSManagedObjectContext * newContext = [[[NSThread currentThread] threadDictionary] valueForKey:@"managedObjectContext"];
  if(newContext) return newContext;
  
  newContext = [NSManagedObjectContext new];
  [newContext setPersistentStoreCoordinator:[NSApp persistentStoreCoordinator]];
  [[[NSThread currentThread] threadDictionary] setValue:newContext forKey:@"managedObjectContext"];
  return newContext;
}

- (SongsArrayController*) songsArrayController {
 if (songsArrayController) return songsArrayController;
 songsArrayController = [SongsArrayController new];
 [songsArrayController setManagedObjectContext:[self managedObjectContextForThread]];
 return songsArrayController;
}

/********************
 * ACCESSOR METHODS *
 ********************/

- (ProgressWindowController*) progressWindowController {
  return [[NSApp mainWindowController] progressWindowController];
}

@end
