#import <CoreData/CoreData.h>

@class Slide;

@interface Presentation : NSManagedObject {}

// Attributes
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *footnote;

// Associations
@property (nonatomic) NSSet *slides;

// Class Methods
+ (BOOL) validTitle:(NSString*)suggestedTitle;
+ (BOOL) validContent:(NSString*)suggestedContent;
+ (NSString*) normalizeTitle:(NSString*)rawTitle;
+ (NSString*) normalizeContent:(NSString*)rawContent;
+ (NSArray*) contentToVerses:(NSString*)rawContent;

// Instance Methods
- (void) setTitle:(NSString*)value;
- (void) setContent:(NSString*)value;
- (void) updateKeywords;
- (NSArray*) sortedSlides;

@end

// Mandatory CoreData Accessors for Associations
@interface Presentation (CoreDataGeneratedAccessors)

- (void)addSlidesObject:(Slide *)value;
- (void)removeSlidesObject:(Slide *)value;
- (void)addSlides:(NSSet *)value;
- (void)removeSlides:(NSSet *)value;

@end

