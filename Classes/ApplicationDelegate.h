@class MainWindowController;
@class ProjectorController;
@class SongsArrayController;
@class PDFsArrayController;
@class PlaylistArrayController;
@class ProjectorController;

@interface ApplicationDelegate : NSApplication {

  /*************
   * VARIABLES *
   *************/
  
  // Window Controllers
  MainWindowController *mainWindowController;
  
  // General Controllers
  ProjectorController *projectorController;

  // Array Controllers
  SongsArrayController *songsArrayController;
  PDFsArrayController *pdfsArrayController;
  PlaylistArrayController *playlistArrayController;
  
  // Object Controllers
  NSObjectController *projectorSlideController;
  
  // Core Data
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
}

/**************
 * PROPERTIES *
 **************/

// Window Controllers
@property (nonatomic, retain, readonly) MainWindowController *mainWindowController;

// General Controllers
@property (nonatomic, retain, readonly) ProjectorController *projectorController;

// Array Controllers
@property (nonatomic, retain, readonly) SongsArrayController *songsArrayController;
@property (nonatomic, retain, readonly) PDFsArrayController *pdfsArrayController;
@property (nonatomic, retain, readonly) PlaylistArrayController *playlistArrayController;

// Object Controllers
@property (nonatomic, retain, readonly) NSObjectController *projectorSlideController;

// Core Data
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

/********************
 * INSTANCE METHODS *
 ********************/

// Application Initialization
- (void) setupControllerObservers;

// Data Core Backend
- (NSString*) applicationSupportDirectory;

// Instance Methods
- (IBAction) saveAction:sender;
- (NSScreen*) suggestedScreenForProjector;
- (BOOL) singleScreenMode;

@end