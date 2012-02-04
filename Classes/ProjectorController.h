@class ProjectorWindowController;
@class ProjectorPDFView;
@class ProjectorView;

#import "Slide.h"

@interface ProjectorController : NSObject {

  // Views
  ProjectorView *projectorView;
  ProjectorPDFView *pdfView;
  
  // Window Controllers
  ProjectorWindowController *windowController;

  // Status trackers
  BOOL isLive;

}

/**************
 * PROPERTIES *
 **************/

// Views
@property (nonatomic, readwrite, strong) ProjectorView *projectorView;
@property (nonatomic, readwrite, strong) ProjectorPDFView *pdfView;

// Window Controllers
@property (nonatomic, readwrite, strong) ProjectorWindowController *windowController;

// Status trackers
@property (readwrite) BOOL isLive;

/***********
 * METHODS *
 ***********/

// Projector size caluculation
- (NSSize) recommendedThumbnailSize;
// Live handling
- (void) toggleLive;
- (void) goLive;
- (void) leaveLive;
// Blank slide handling
- (BOOL) isBlank;
- (void) goBlank;
// Slide/PDF handling
- (void) setSlide:(Slide*)newSlide;
- (void) setSlide:(Slide*)newSlide;
- (BOOL) showsPDF;
- (BOOL) showsSlide;




@end