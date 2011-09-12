@class MainWindowController;
@class SongsArrayController;

@interface ApplicationDelegate : NSApplication {

  // Window Controllers
  MainWindowController *mainWindowController;
  
  // Array Controllers
  SongsArrayController *songsArrayController;
  

  // Core Data
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
}


// Window Controllers
@property (nonatomic, retain, readonly) MainWindowController *mainWindowController;

// Array Controllers
@property (nonatomic, retain, readonly) SongsArrayController *songsArrayController;

// Core Data
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

-(IBAction) saveAction:sender;

@end
