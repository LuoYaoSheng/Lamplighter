#import "ProjectorController.h"

#import "ProjectorWindowController.h"
#import "Song.h"
#import "SlideView.h"
#import "ApplicationDelegate.h"
#import "MainWindowController.h"
#import "SongsDrawerViewController.h"
#import "BaseCollectionView.h"
#import "ProjectorWindow.h"
#import "ProjectorView.h"
#import "ProjectorPDFView.h"

@implementation ProjectorController

@synthesize projectorView, pdfView;
@synthesize windowController;
@synthesize isLive;

- (id) init {
  if (self = [super init]) {
    [self initStatusTrackers];
    [self initProjectorView];
    [self initPDFView];
    [self initWindowController];
    [self setupObservers];
  }
  return self;
}

- (void) initStatusTrackers {
  self.isLive = NO;
}

- (void) initProjectorView {
  self.projectorView = [ProjectorView new];
  //[self.projectorView setAutoresizingMask:(NSViewMinXMargin|NSViewWidthSizable|NSViewMaxXMargin|NSViewMinYMargin|NSViewHeightSizable|NSViewMaxYMargin)];
  //[self.projectorView setFrame:NSMakeRect(0, 0, self.projectorView.superview.frame.size.width, self.projectorView.superview.frame.size.height)];
}

- (void) initPDFView {
  self.pdfView = [ProjectorPDFView new];
  self.pdfView.displayMode = kPDFDisplaySinglePage;
  self.pdfView.autoScales = YES;
  self.pdfView.backgroundColor = [NSColor blackColor];
}

- (void) initWindowController {
  self.windowController = [[ProjectorWindowController alloc] initWithWindowNibName:@"ProjectorWindow"];
}

- (void) setupObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nsApplicationDidChangeScreenParametersNotification:) name:NSApplicationDidChangeScreenParametersNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionViewSelectionDidChangeNotification:) name:CollectionViewSelectionDidChangeNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slideViewWasDoubleClickedNotification:) name:SlideViewWasDoubleClickedNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PDFThumbnailViewWasDoubleClickedNotification:) name:PDFThumbnailViewWasDoubleClickedNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PDFViewWasDoubleClickedNotification:) name:PDFViewWasDoubleClickedNotification object:nil];
}

/******************************
 * PROJECTOR SIZE CALCULATION *
 ******************************/

- (NSSize) sizeOfProjectorView {
  NSRect frame = [[NSApp suggestedScreenForProjector] frame];
  if (self.isLive) frame = self.projectorView.frame;
  return NSMakeSize(frame.size.width, frame.size.height);
}

- (NSSize) recommendedThumbnailSize {
  NSSize size = [self sizeOfProjectorView];
  CGFloat width = size.width;
  CGFloat height = size.height;
  CGFloat ratio = width / height;
  // Derive the preview slide size from the MainWindow screen size
  NSRect screenRect = [[[[NSApp mainWindowController] window] screen] frame];
  if (ratio > 1) {
    // Make the horizontal projector slide fit into the preview slide constraints
    width = screenRect.size.width / 5;
    height = width / ratio;
  } else {
    // Make the vertical projector slide fit into the preview slide constraints
    height = screenRect.size.height / 6;
    width = height * ratio;
  }
  return NSMakeSize(width, height);
}

/****************
 * LIVE HANDING *
 ****************/

- (void) toggleLive {
  [self isLive] ? [self leaveLive] : [self goLive];
}

- (void) goLive {

  if ([NSApp singleScreenMode]) {
    [self.windowController showWindow:self];
    [[self.windowController window] setContentView:self.projectorView];
  } else {
    NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, NULL, NSFullScreenModeApplicationPresentationOptions, nil];
    [self.projectorView enterFullScreenMode:[[NSScreen screens] objectAtIndex:1] withOptions:opts];
  }
  
  self.isLive = YES;
  [self sendLiveStatusChangedNotification];
  //[self.windowController ensureCorrectFullscreenState];
}

- (void) leaveLive {

  if ([NSApp singleScreenMode]) {
    [self.windowController close];
  } else {
    NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, NULL, NSFullScreenModeApplicationPresentationOptions, nil];
    [self.projectorView enterFullScreenMode:[[NSScreen screens] objectAtIndex:1] withOptions:opts];
  }
  
  self.isLive = NO;
  [self sendLiveStatusChangedNotification];
  //[[self windowController] ensureCorrectFullscreenState];
}

- (void) sendLiveStatusChangedNotification {
  [[NSNotificationCenter defaultCenter] postNotificationName:LiveStatusDidChangeNotification object:self];
}

/************************
 * BLANK SLIDE HANDLING *
 ************************/
 
- (BOOL) isBlank {
  //return ([self showsPDF] || [self showsSlide]) ? NO : YES;
  return [[self.projectorView subviews] count] == 0;
}

- (void) goBlank {
  [self.projectorView setSubviews:[NSArray arrayWithObjects:nil]];
  //[self setSlide:NULL];
}

/**********************
 * SLIDE/PDF HANDLING *
 **********************/

// The PDFView does this automatically.
// So there is no need for a setPDF method.
- (void) setSlide:(Slide*)newSlide {
  [[NSApp projectorSlideController] setContent:newSlide];
  [self  updateSlide];
}

- (void) updateSlide {
  [self showView:(NSView*)[[SlideView alloc] initWithSlide:[[NSApp projectorSlideController] selection] andPreviewMode:NO]];
}

- (void) updatePDF {
  [self showView:(NSView*)self.pdfView];
}

- (void) showView:(NSView*)view {
  [view setAutoresizingMask:(NSViewMinXMargin|NSViewWidthSizable|NSViewMaxXMargin|NSViewMinYMargin|NSViewHeightSizable|NSViewMaxYMargin)];
  [view setFrame:NSMakeRect(0, 0, self.projectorView.frame.size.width, self.projectorView.frame.size.height)];
  [self.projectorView setSubviews:[NSArray arrayWithObjects: view, nil]];
}

- (BOOL) showsPDF {
  return [[[self.projectorView subviews] lastObject] class] == [ProjectorPDFView class];
}

- (BOOL) showsSlide {
  return [[[self.projectorView subviews] lastObject] class] == [SlideView class];
}

/*
- (void) goFullscreen:(NSView*)view {
  // NSNumber *presentationOptions = [NSNumber numberWithUnsignedInt:(NSApplicationPresentationAutoHideMenuBar|NSApplicationPresentationAutoHideDock|NSApplicationPresentationDisableProcessSwitching)];
  NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSFullScreenModeAllScreens, NULL, NSFullScreenModeApplicationPresentationOptions, nil];
  [view enterFullScreenMode:[[NSScreen screens] objectAtIndex:1] withOptions:opts];
  [[[NSApp mainWindowController] window] makeKeyWindow];
}

- (void) ensureCorrectFullscreenState { 
  if ([[NSScreen screens] count] == 1) {
    // If there is just one screen, make sure nothing is in fullscreen mode here.
    // This method won't fail if the window is not in fullscreen mode.
    //[self.window setIsVisible:YES];
    //[self.window exitFullScreen];
  } else {
    if ([[NSApp projectorController] isLive] && ![self.projectorView isInFullScreenMode]) {
      // If there is a second screen, and we are in live mode, and we are not already in fullscreen mode
      // then go fullscreen on the secondary screen.
      //[self.window goFullscreenOnScreen:[[NSScreen screens] objectAtIndex:1]];
      //[self.window setIsVisible:NO];
    }
  }
}
*/

/*****************
 * NOTIFICATIONS *
 *****************/


// Notifications

- (void) nsApplicationDidChangeScreenParametersNotification:(NSNotification*)notification {
  //[self ensureCorrectFullscreenState];
}

- (void) collectionViewSelectionDidChangeNotification:(NSNotification*)notification {
  NSCollectionView *collectionView = [notification object];
  NSUInteger selectionIndex = [[collectionView selectionIndexes] firstIndex];
  if ((int)selectionIndex == -1) {
    [self goBlank];
  } else {
    [self setSlide:[(SlideView*)[[collectionView itemAtIndex:selectionIndex] view] slide]];
  }
}

- (void) PDFThumbnailViewWasDoubleClickedNotification:(NSNotification*)notification {
   [self updatePDF];
}

- (void) PDFViewWasDoubleClickedNotification:(NSNotification*)notification {
  [[self.windowController window] toggleFullscreen];
}

- (void) slideViewWasDoubleClickedNotification:(NSNotification*)notification {
  SlideView *slideView = [notification object];
  if ([slideView collectionView] == NULL) {
    [[self.windowController window] toggleFullscreen];
  } else {
    if ([slideView collectionView] == [[NSApp mainWindowController] liveviewCollectionView] && ![self isLive]) {
      [self goLive];
    }
  }
}

@end