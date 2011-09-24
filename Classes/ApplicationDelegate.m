#import "ApplicationDelegate.h"

#import "MainWindowController.h"
#import "SongsArrayController.h"
#import "PlaylistArrayController.h"

@implementation ApplicationDelegate

/******************************
 * APPLICATION INITIALIZATION *
 ******************************/

- (void) applicationDidFinishLaunching:(NSNotification*)notification {
	[self.mainWindowController showWindow:self];
  // Changing the Application Logo to turn on its light
  NSImage *app_logo_on = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app_logo_on" ofType:@"icns"]];
  [self setApplicationIconImage:app_logo_on];
  [app_logo_on release];
}

/**********************
 * WINDOW CONTROLLERS *
 **********************/

- (MainWindowController*) mainWindowController {
  if (mainWindowController) return mainWindowController;
	mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
  return mainWindowController;
}

/*********************
 * ARRAY CONTROLLERS *
 *********************/

- (SongsArrayController*) songsArrayController {
  if (songsArrayController) return songsArrayController;
  songsArrayController = [SongsArrayController new];
  [songsArrayController setManagedObjectContext:self.managedObjectContext];
  NSSortDescriptor *sortByTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
  [songsArrayController setSortDescriptors:[NSArray arrayWithObject:sortByTitle]];
 return songsArrayController;
}

- (PlaylistArrayController*) playlistArrayController {
  if (playlistArrayController) return playlistArrayController;
  playlistArrayController = [PlaylistArrayController new];
  [playlistArrayController setManagedObjectContext:self.managedObjectContext];
  return playlistArrayController;
}

/**********************
 * OBJECT CONTROLLERS *
 **********************/

- (NSObjectController*) projectorSlideController {
  if (projectorSlideController) return projectorSlideController;
  projectorSlideController = [NSObjectController new];
  [projectorSlideController setManagedObjectContext:self.managedObjectContext];
  return projectorSlideController;
}

/*********************
 * DATA CORE BACKEND *
 *********************/

/*
 * Returns the support directory for the application, used to store the Core Data
 * store file.  This code uses a directory named "Lamplighter" for
 * the content, either in the NSApplicationSupportDirectory location or (if the
 * former cannot be found), the system's temporary directory.
 */
- (NSString*) applicationSupportDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
  NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
  return [basePath stringByAppendingPathComponent:@"Lamplighter"];
}

/*
 * Creates, retains, and returns the managed object model for the application 
 * by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel*) managedObjectModel {
  if (managedObjectModel) return managedObjectModel;
  managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
  return managedObjectModel;
}

/*
 * Returns the persistent store coordinator for the application.  This 
 * implementation will create and return a coordinator, having added the 
 * store for the application to it.  (The directory for the store is created, 
 * if necessary.)
 */
- (NSPersistentStoreCoordinator*) persistentStoreCoordinator {
  if (persistentStoreCoordinator) return persistentStoreCoordinator;
  
  NSManagedObjectModel *mom = self.managedObjectModel;
  if (!mom) {
    NSAssert(NO, @"Managed object model is nil");
    NSLog(@"%@:%s No model to generate a store from", [self class], _cmd);
    return nil;
  }
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSString *applicationSupportDirectory = [self applicationSupportDirectory];
  NSError *error = nil;
  if ( ![fileManager fileExistsAtPath:applicationSupportDirectory isDirectory:NULL] ) {
    if (![fileManager createDirectoryAtPath:applicationSupportDirectory withIntermediateDirectories:NO attributes:nil error:&error]) {
      NSAssert(NO, ([NSString stringWithFormat:@"Failed to create App Support directory %@ : %@", applicationSupportDirectory,error]));
      NSLog(@"Error creating application support directory at %@ : %@",applicationSupportDirectory,error);
      return nil;
    }
  }
  
  NSURL *url = [NSURL fileURLWithPath: [applicationSupportDirectory stringByAppendingPathComponent: @"storedata"]];
  persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: mom];
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSBinaryStoreType configuration:nil URL:url options:nil error:&error]){
    [NSApp presentError:error];
    [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
    return nil;
  }    
  return persistentStoreCoordinator;
}

/*
 * Returns the managed object context for the application (which is already
 * bound to the persistent store coordinator for the application.) 
 */
- (NSManagedObjectContext*) managedObjectContext {
  if (managedObjectContext) return managedObjectContext;

  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
    [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
    NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    [self presentError:error];
    return nil;
  }
  managedObjectContext = [NSManagedObjectContext new];
  [managedObjectContext setPersistentStoreCoordinator: coordinator];
  return managedObjectContext;
}

/*
 * Returns the NSUndoManager for the application.  In this case, the manager
 * returned is that of the managed object context for the application.
 */
- (NSUndoManager*) windowWillReturnUndoManager:(NSWindow*)window {
  return [self.managedObjectContext undoManager];
}

/********************
 * INSTANCE METHODS *
 ********************/

/*
 * Performs the save action for the application, which is to send the save:
 * message to the application's managed object context.  Any encountered errors
 * are presented to the user.
 */
- (IBAction) saveAction:sender {
  NSError *error = nil;
  if (![self.managedObjectContext commitEditing]) {
    NSLog(@"%@:%s unable to commit editing before saving", [self class], _cmd);
  }
  if (![self.managedObjectContext save:&error]) {
    [self presentError:error];
  }
}

/**********************
 * NOTIFICATION HOOKS *
 **********************/

/*
 * Implementation of the applicationShouldTerminate: method, used here to
 * handle the saving of changes in the application managed object context
 * before the application terminates.
 */
- (NSApplicationTerminateReply) applicationShouldTerminate:(NSApplication*)sender {
  if (!self.managedObjectContext) return NSTerminateNow;

  if (![self.managedObjectContext commitEditing]) {
    NSLog(@"%@:%s unable to commit editing to terminate", [self class], _cmd);
    return NSTerminateCancel;
  }
  if (![self.managedObjectContext hasChanges]) return NSTerminateNow;

  NSError *error = nil;
  if (![self.managedObjectContext save:&error]) {

    // This error handling simply presents error information in a panel with an 
    // "Ok" button, which does not include any attempt at error recovery (meaning, 
    // attempting to fix the error.)  As a result, this implementation will 
    // present the information to the user and then follow up with a panel asking 
    // if the user wishes to "Quit Anyway", without saving the changes.

    // Typically, this process should be altered to include application-specific 
    // recovery steps.  
            
    BOOL result = [sender presentError:error];
    if (result) return NSTerminateCancel;

    NSString *question = NSLocalizedString(@"Could not save changes while quitting.  Quit anyway?", @"Quit without saves error question message");
    NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
    NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
    NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:question];
    [alert setInformativeText:info];
    [alert addButtonWithTitle:quitButton];
    [alert addButtonWithTitle:cancelButton];

    NSInteger answer = [alert runModal];
    [alert release];
    alert = nil;
    if (answer == NSAlertAlternateReturn) return NSTerminateCancel;
  }
  return NSTerminateNow;
}


/****************
 * DEALLOCATION *
 ****************/

/*
 * Implementation of dealloc, to release the retained variables.
 */
- (void) dealloc {
  // Window Controllers
  [mainWindowController release];
  // Array Controllers
  [songsArrayController release];
  [playlistArrayController release];
  // Core Data
  [managedObjectContext release];
  [persistentStoreCoordinator release];
  [managedObjectModel release];
  [super dealloc];
}

@end