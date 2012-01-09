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
@property (nonatomic, readonly) MainWindowController *mainWindowController;

// General Controllers
@property (nonatomic, readonly) ProjectorController *projectorController;

// Array Controllers
@property (nonatomic, readonly) SongsArrayController *songsArrayController;
@property (nonatomic, readonly) PDFsArrayController *pdfsArrayController;
@property (nonatomic, readonly) PlaylistArrayController *playlistArrayController;

// Object Controllers
@property (nonatomic, readonly) NSObjectController *projectorSlideController;

// Core Data
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

/**************
 * FILESYSTEM *
 **************/

- (BOOL) ensureApplicationSupportDirectory;
- (BOOL) ensureDatabaseDirectory;
- (BOOL) ensurePDFsDirectory;
- (NSURL*) databaseDirectoryURL;
- (NSURL*) pdfsDirectoryURL;
- (NSURL*) databaseFileURL;
- (NSString*) databaseDirectoryPath;
- (NSString*) pdfsDirectoryPath;

/******************
 * ERROR HANDLING *
 ******************/

- (void) throwError:(NSUInteger)code withInfo:(NSString*)info;

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