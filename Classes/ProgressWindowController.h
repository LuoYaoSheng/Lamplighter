@interface ProgressWindowController : NSWindowController {
  
  IBOutlet NSProgressIndicator *progressIndicator;
  
}

@property (nonatomic) IBOutlet NSProgressIndicator *progressIndicator;


- (void) setMaxValue:(NSUInteger)newValue;
- (void) setProgressValue:(double)newValue;
- (void) show;
- (void) orderOut;
- (void) sheetEnded:(NSWindow*)sheet returnCode:(int)code contextInfo:(void*)context;

@end