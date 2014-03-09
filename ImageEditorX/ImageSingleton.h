//
//  ImageSingleton.h
//  ImageEditorX
//
//  Created by Judiandar Sudarman on 11/3/13.
//
//

#import <Foundation/Foundation.h>

@interface ImageSingleton : UIImageView

{
    UIImage *templateImage;
    UIImage *modImage;
    UIImage *finalImage;
}

// Your property settings for your variables go here
// here's one example:
@property (nonatomic, retain) UIImage *templateImage;
@property (nonatomic, retain) UIImage *modImage;
@property (nonatomic, retain) UIImage *finalImage;

// This is the method to access this Singleton class
+ (ImageSingleton *)sharedSingleton;


@end
