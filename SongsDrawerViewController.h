@class SongsDrawer;

@interface SongsDrawerViewController : NSViewController {

  NSWindow *mainWindow;
  SongsDrawer *songsDrawer;

}

@property (nonatomic, retain) IBOutlet NSWindow *mainWindow;

-(void) loadSongsDrawer;

@end
