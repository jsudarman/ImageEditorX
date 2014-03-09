//
//  ViewController.h
//
//  Created by Judiandar Sudarman on 11/1/13.
//

#import <UIKit/UIKit.h>
#import "TemplateViewController.h"
#import <MessageUI/MessageUI.h>
#import "SKPSMTPMessage.h"
#import "AuthNet.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate,UIActionSheetDelegate,UIPickerViewDelegate,SKPSMTPMessageDelegate,AuthNetDelegate> {
    
    UIView *vwToCrop;
    UIImagePickerController *objImgPicker;
    __unsafe_unretained IBOutlet UIButton *topLeftBtn;
    __unsafe_unretained IBOutlet UIButton *topRightBtn;
    __unsafe_unretained IBOutlet UIButton *bottomLeftBtn;
    __unsafe_unretained IBOutlet UIButton *bottomRightBtn;
    CGFloat topLeftX;
    CGFloat topLeftY;
    
    CGFloat topRightX;
    CGFloat topRightY;
    
    CGFloat bottomLeftX;
    CGFloat bottomLeftY;
    
    CGFloat bottomRightX;
    CGFloat bottomRightY;
    
    CGFloat imageX;
    CGFloat imageY;
    
    UIImageView *croppedImageView;
    UIImage *image320x480;
    
    NSString *sessionToken;
    
    //new properties
    CGPoint location;
    CGPoint startCGPoint;
    IBOutlet UIImageView *aImgView;
    UIBezierPath *mainPath;
    IBOutlet UIButton *btnCrop;
    IBOutlet UIButton *btnClearCrop;
    
    NSMutableArray *pointArray;
    int height;
    int width;
    UIImagePickerController *imgPicker;
    NSInteger cameraflag;
    UIImage *imgofpicker;
    IBOutlet UIView *mainSubView;
    

}
@property CGPoint location;
@property (retain, nonatomic) IBOutlet UIImageView *imvCroppedImage;
@property (retain, nonatomic) IBOutlet UIImageView *imvOriginalImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIBarButtonItem *btnCamera;

@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonCamera;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonLibrary;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonOverlay;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonTemplate;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonSend;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *flexSpace;


@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonCrop;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonUse;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonClear;

@property(nonatomic,retain)UIImage *currentImage;

- (IBAction)SelectImageFrom:(id)sender;
- (IBAction)SelectTemplateFrom:(id)sender;
- (IBAction)OverlayImages:(id)sender;
- (IBAction)btnCropTapped:(id)sender;
- (IBAction)SendImage:(id)sender;
- (UIImage*)imageWithRotation:(UIImage*)image;
- (void)setViewForCropping;
- (void)cropImage;
- (IBAction)CropImages:(id)sender;
- (IBAction)UseImages:(id)sender;
- (IBAction)ClearImages:(id)sender;

@end
