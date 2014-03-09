//
//  ImageSingleton.m
//  ImageEditorX
//
//  Created by Judiandar Sudarman on 11/3/13.
//
//

#import "ImageSingleton.h"

@implementation ImageSingleton


@synthesize modImage;
@synthesize templateImage;

static ImageSingleton *shared = NULL;


- (id)init
{
    if ( self = [super init] )
    {
        modImage = NULL;
        templateImage = NULL;
        finalImage = NULL;
    }
    return self;
    
}

+ (ImageSingleton *)sharedSingleton
{
    @synchronized(shared)
    {
        if ( !shared || shared == NULL )
        {
            // allocate the shared instance, because it hasn't been done yet
            shared = [[ImageSingleton alloc] init];
        }
        
        return shared;
    }
}

- (void)dealloc
{
    NSLog(@"Deallocating singleton...");
    
    
}

@end
