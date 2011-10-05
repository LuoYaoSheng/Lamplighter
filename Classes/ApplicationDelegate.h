@class MainWindowController;
@class ProjectorController;
@class SongsArrayController;
@class PlaylistArrayController;
@class ProjectorController;

@interface ApplicationDelegate : NSApplication {

  // Window Controllers
  MainWindowController *mainWindowController;
  
  // Other Controllers
  ProjectorController *projectorController;

  // Array Controllers
  SongsArrayController *songsArrayController;
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

// Other Controllers
@property (nonatomic, retain, readonly) ProjectorController *projectorController;

// Array Controllers
@property (nonatomic, retain, readonly) SongsArrayController *songsArrayController;
@property (nonatomic, retain, readonly) PlaylistArrayController *playlistArrayController;

// Object Controllers
@property (nonatomic, retain, readonly) NSObjectController *projectorSlideController;

// Core Data
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

/***********
 * METHODS *
 ***********/

-(IBAction) saveAction:sender;

@end