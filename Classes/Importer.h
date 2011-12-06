@class ProgressWindowController;

@interface Importer : NSObject

- (void) setProgress:(float)progress;
- (ProgressWindowController*) progressWindowController;

@end
