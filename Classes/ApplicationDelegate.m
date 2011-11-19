#import "ApplicationDelegate.h"

#import "MainWindowController.h"
#import "SongsArrayController.h"
#import "PDFsArrayController.h"
#import "PlaylistArrayController.h"
#import "ProjectorController.h";

@implementation ApplicationDelegate

/******************************
 * APPLICATION INITIALIZATION *
 ******************************/

/* This is the first method that is called on application launch.
 */
- (void) applicationDidFinishLaunching:(NSNotification*)notification {
	[self.mainWindowController showWindow:self];
  [self setupControllerObservers];
}

- (void) setupControllerObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self.projectorController selector:@selector(collectionViewSelectionDidChangeNotification:) name:CollectionViewSelectionDidChangeNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self.projectorController selector:@selector(slideViewWasDoubleClickedNotification:) name:SlideViewWasDoubleClickedNotification object:nil];
}

/**********************
 * WINDOW CONTROLLERS *
 **********************/

/* The Window Controller for the Main Window.
 */
- (MainWindowController*) mainWindowController {
  if (mainWindowController) return mainWindowController;
	mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
  return mainWindowController;
}

/*********************
 * OTHER CONTROLLERS *
 *********************/

/* This Controller acts as a single-point-of-control for the projector. Whatever you want to do
 * with the projector, it has to go through this controller.
 */
- (ProjectorController*) projectorController {
  if (projectorController) return projectorController;
	projectorController = [ProjectorController new];
  [projectorController goBlank];
  return projectorController;
}

/*********************
 * ARRAY CONTROLLERS *
 *********************/

/* This Array Controller is backed by Core Data and contains all Songs available in Lamplighter.
 */
- (SongsArrayController*) songsArrayController {
  if (songsArrayController) return songsArrayController;
  songsArrayController = [SongsArrayController new];
  [songsArrayController setManagedObjectContext:self.managedObjectContext];
  NSSortDescriptor *sortByTitle = [[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];
  [songsArrayController setSortDescriptors:[NSArray arrayWithObject:sortByTitle]];
  return songsArrayController;
}

- (PDFsArrayController*) pdfsArrayController {
  if (pdfsArrayController) return pdfsArrayController;
  pdfsArrayController = [PDFsArrayController new];
  [pdfsArrayController setManagedObjectContext:self.managedObjectContext];
  return pdfsArrayController;
}

/* This Array Controller is *not* backed by Core Data. It's a simple mutable Array that holds
 * mere *references* to Core Data objects. You can think of it as a short-lived "songs for today"
 * list that makes it easier to find songs.
 */
- (PlaylistArrayController*) playlistArrayController {
  if (playlistArrayController) return playlistArrayController;
  playlistArrayController = [PlaylistArrayController new];
  [playlistArrayController setManagedObjectContext:self.managedObjectContext];
  return playlistArrayController;
}

/**********************
 * OBJECT CONTROLLERS *
 **********************/

/* This Object Controller is *not* backed by Core Data. Its solemn purpose is to hold the reference
 * to a single slide - the one that is to be presented on the projector.
 */
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
  
  [self ensureDatabaseDirectory];
  
  persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: mom];
  NSError *error = nil;
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSBinaryStoreType configuration:nil URL:[self databaseFileURL] options:nil error:&error]){
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
  debugLog(@"%@:%s Instantiating...", [self class], _cmd);

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

/**************
 * FILESYSTEM *
 **************/

- (BOOL) ensureApplicationSupportDirectory {
  NSString *applicationSupportDirectory = [self applicationSupportDirectory];
  BOOL isDirectory;
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if ([fileManager fileExistsAtPath:applicationSupportDirectory isDirectory:&isDirectory] && isDirectory) return YES;
  NSError *error = nil;
  if ([fileManager createDirectoryAtPath:applicationSupportDirectory withIntermediateDirectories:NO attributes:nil error:&error]) return YES;
  NSAssert(NO, ([NSString stringWithFormat:@"Failed to create Lamplighter support directory %@ : %@", applicationSupportDirectory, error]));
  return NO;
}

- (BOOL) ensureDatabaseDirectory {
  [self ensureApplicationSupportDirectory];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  BOOL isDirectory;
  if ([fileManager fileExistsAtPath:[self databaseDirectoryPath] isDirectory:&isDirectory] && isDirectory) return YES;
  NSError *error = nil;
  if ([fileManager createDirectoryAtPath:[self databaseDirectoryPath] withIntermediateDirectories:NO attributes:nil error:&error]) return YES;
  [self throwError:201 withInfo:[error description]];
  return NO;
}

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

- (NSURL*) databaseDirectoryURL {
  return [NSURL fileURLWithPath:[[self applicationSupportDirectory] stringByAppendingPathComponent: @"database"]];
}

- (NSURL*) databaseFileURL {
  return [NSURL URLWithString:@"database" relativeToURL:[self databaseDirectoryURL]];
}

- (NSString*) databaseDirectoryPath {
  return [[self databaseDirectoryURL] path];
}

/******************
 * ERROR HANDLING *
 ******************/

- (void) throwError:(NSUInteger)code withInfo:(NSString*)info {
  NSString *message;
  switch (code) {
    case 201:
      message = @"Sorry, the database directory could not be created. ";
      break;
    default:
      message = @"Sorry, an unknown error occured. ";
      break;
  }
  message = [message stringByAppendingString:info];
  NSMutableDictionary *ui = [NSMutableDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
  NSError *appError = [NSError errorWithDomain:ErrorDomain code:code userInfo:ui];
  [self presentError:appError];
  exit(code);
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

- (NSScreen*) suggestedScreenForProjector {
  if ([self singleScreenMode]) {
    // Single screen: Projector in a window mode
    return [NSScreen mainScreen];
  } else {
    // Multiple screens: Projector on secondary screen mode
    return [[NSScreen screens] lastObject];
  }
}

- (BOOL) singleScreenMode {
  return ([[NSScreen screens] count] == 1);
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
  // Other Controllers
  [projectorController release];
  // Array Controllers
  [songsArrayController release];
  [playlistArrayController release];
  // Object Controllers
  [projectorSlideController release];
  // Core Data
  [managedObjectContext release];
  [persistentStoreCoordinator release];
  [managedObjectModel release];
  [super dealloc];
}

@end