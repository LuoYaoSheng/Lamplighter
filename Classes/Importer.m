#import "Importer.h"

#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "ProgressWindowController.h"

@implementation Importer


- (void) setProgress:(float)progress {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  
  [dict setValue:[NSNumber numberWithFloat:progress] forKey:@"progress"];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:ProgressDidChangeNotification object:self userInfo:dict];
  
}

/********************
 * ACCESSOR METHODS *
 ********************/

- (ProgressWindowController*) progressWindowController {
  return [[NSApp mainWindowController] progressWindowController];
}

@end
