#import "Presentation.h"
#import "Slide.h"

@implementation Presentation 

// Note that the "content" is never stored in the CoreData object, it's derived from the slides
@dynamic title;
@dynamic footnote;
@dynamic slides;

/*****************
 * CLASS METHODS *
 *****************/

+ (BOOL) validTitle:(NSString*)suggestedTitle {
  NSString *normalizedTitle = [Presentation normalizeTitle:suggestedTitle];
  if ([normalizedTitle length] > 0) return YES; else return NO;
}

+ (BOOL) validContent:(NSString*)suggestedContent {
  NSString *normalizedContent = [self normalizeContent:suggestedContent];
  if ([normalizedContent length] > 0) return YES; else return NO;
}

+ (NSString*) normalizeTitle:(NSString*)rawTitle {
  return [rawTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString*) normalizeContent:(NSString*)rawContent {
  NSArray *verses = [Presentation contentToVerses:rawContent];
  return [verses componentsJoinedByString:@"\n\n"];
}

+ (NSArray*) contentToVerses:(NSString*)rawContent {
  NSArray *rawVerses = [rawContent componentsSeparatedByString: @"\n\n"];
  NSMutableArray *normalizedVerses = [[NSMutableArray alloc] init];
  for (NSString *rawVerse in rawVerses) {
    NSString *normalizedVerse = [rawVerse stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([normalizedVerse length] > 0) [normalizedVerses addObject:normalizedVerse];
  }  
  NSArray *result = [[NSArray alloc] initWithArray:normalizedVerses];
  return result;
}

/********************
 * INSTANCE METHODS *
 ********************/

- (void) setTitle:(NSString*)value {
  [self willChangeValueForKey:@"title"];
  [self setPrimitiveValue:[Presentation normalizeTitle:value] forKey:@"title"];
  [self didChangeValueForKey:@"title"];
}


- (void) setContent:(NSString*)value {
  NSArray *verses = [Presentation contentToVerses:value];
  int numberOfSlides = [[self slides] count];
  int numberOfVerses = [verses count];
  
  if (numberOfSlides > 0 && numberOfSlides == numberOfVerses){
    // How about that! The number of verses did not change by editing the content of this song.
    debugLog(@"How about that!");
    NSArray *verses = [Presentation contentToVerses:value];
    int position = 0;
    for (Slide *slide in [self slides]) {
      [slide setContent:[verses objectAtIndex:position]];
      [slide setPosition:[[NSNumber alloc] initWithInt:position]];
      position += 1;
    }
    
  } else {
    // Looks like we have to create all slides for this song from scratch.
    // Let's first remove all current slides
    [self removeSlides:[self slides]];    
    // Hook up to the database
    NSManagedObjectContext *context = [self managedObjectContext];
    // And make one new slide for each verse
    int position = 0;
    for (NSString *verse in verses) {
      if ([verse length] > 0) {
        Slide *slide = [NSEntityDescription insertNewObjectForEntityForName :@"Slide" inManagedObjectContext: context];
        [slide setValue:verse forKey:@"content"];
        [slide setPosition:[[NSNumber alloc] initWithInt:position]];
        [self addSlidesObject:slide];
        position += 1;
      }
    }
  }
}

/*
+ (NSString*) decomposeAndFilterString: (NSString*) string {
  NSMutableString *decomposedString = [[string decomposedStringWithCanonicalMapping] mutableCopy];
  NSCharacterSet *nonBaseSet = [NSCharacterSet nonBaseCharacterSet];
  NSRange range = NSMakeRange([decomposedString length], 0);
  
  while (range.location > 0) {
    range = [decomposedString rangeOfCharacterFromSet:nonBaseSet
                                              options:NSBackwardsSearch range:NSMakeRange(0, range.location)];
    if (range.length == 0) {
      break;
    }
    [decomposedString deleteCharactersInRange:range];
  }
  
  return [decomposedString autorelease];
}
*/

- (void) willSave {
  [self updateKeywords];
  [super willSave];
}

- (void) updateKeywords {
  NSArray *values = [[NSArray alloc] initWithObjects: self.title, self.content, self.footnote, nil];  
  [self setPrimitiveValue:[values componentsJoinedByString:@" "] forKey:@"keywords"];
}

- (NSArray*) sortedSlides {
  NSArray *result;
  NSSortDescriptor *sortByPosition = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
  result = [[self primitiveValueForKey:@"slides"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByPosition]];
  return result;
}

- (NSString*) content {
  //NSSortDescriptor *sortByPosition = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
  //NSArray *sortedSlides = [[self primitiveValueForKey:@"slides"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByPosition]];
  
  NSMutableArray *slidesContents = [NSMutableArray array];
  for (Slide *slide in [self sortedSlides]) {
    [slidesContents addObject:[slide content]];
  }
  
  return [slidesContents componentsJoinedByString:@"\n\n"];
}

@end
