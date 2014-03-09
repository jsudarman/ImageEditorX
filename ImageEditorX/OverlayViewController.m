//
//  OverlayViewController.m
//  ImageEditorX
//
//  Created by Judiandar Sudarman on 11/1/13.
//
//

#import "OverlayViewController.h"
#import "ImageSingleton.h"

@interface OverlayViewController ()

@end

@implementation OverlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];

    
    self.imvTemplate.image = imgSingleton.templateImage;
    [self.btnCropped setBackgroundImage:imgSingleton.modImage forState:UIControlStateNormal];
    
    //overlay the images and put it into singleton
    UIImage *templateImage = imgSingleton.templateImage;
    UIImage *modImage = imgSingleton.modImage;
    CGSize templateSize = [templateImage size];
    CGSize modSize = [modImage size];
    UIGraphicsBeginImageContext(templateSize);
    [templateImage drawInRect:CGRectMake(0,0,templateSize.width,templateSize.height)];
    [modImage drawInRect:CGRectMake(self.btnCropped.frame.origin.x,self.btnCropped.frame.origin.y,modSize.width,modSize.height)];
    UIImage *finalsImage = UIGraphicsGetImageFromCurrentImageContext();
    imgSingleton.finalImage = finalsImage;
    UIGraphicsEndImageContext();

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
