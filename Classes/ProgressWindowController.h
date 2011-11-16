@interface ProgressWindowController : NSWindowController {
  
  IBOutlet NSProgressIndicator *progressIndicator;
  
}

@property (nonatomic, retain) IBOutlet NSProgressIndicator *progressIndicator;

- (void) setProgressValue:(double)newValue;

@end