//
//  ViewController.m
//
//  Created by Judiandar Sudarman on 11/1/13.
//

#import "ViewController.h"
#import "OverlayViewController.h"
#import "ImageSingleton.h"
#import <MessageUI/MessageUI.h>
#import "NSData+Base64Additions.h"
#import "MobileDeviceLoginRequest.h"
#import "AuthNet.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "PaymentViewController.h"

#define MAX_CROPPING_HEIGHT 250
#define MAX_CROPPING_WIDTH 250
#define MIN_CROPPING_HEIGHT 150
#define MIN_CROPPING_WIDHT 150



@implementation ViewController
@synthesize imvCroppedImage;
@synthesize imvOriginalImage;
@synthesize btnCamera, currentImage;

static inline double radians (double degrees) {return degrees * M_PI/180;}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [btnCamera setEnabled:NO];
    }
    
    
    // create nav button items
    
    _buttonLibrary = [[UIBarButtonItem alloc] initWithTitle:@"Library" style:UIBarButtonItemStylePlain target:self action:@selector(SelectImageFrom:)];
    [[self navigationItem] setLeftBarButtonItem:_buttonLibrary];
    
    _buttonCamera = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(SelectImageFrom:)];
    _buttonCamera.tag = 1;
    //[[self navigationItem] setRightBarButtonItem:_buttonCamera];
    
    _buttonCrop = [[UIBarButtonItem alloc] initWithTitle:@"Crop" style:UIBarButtonItemStylePlain target:self action:@selector(CropImages:)];
    
    _buttonUse = [[UIBarButtonItem alloc] initWithTitle:@"Use" style:UIBarButtonItemStylePlain target:self action:@selector(UseImages:)];
    
    _buttonClear = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(ClearImages:)];
    
    
    _flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    [[self navigationItem] setLeftBarButtonItems:[NSArray arrayWithObjects:_buttonLibrary,_flexSpace,_buttonCamera,_flexSpace,_buttonCrop,_flexSpace,_buttonUse,_flexSpace,nil]];
    
    // set initialization parameters with new crop function
    
    
    btnClearCrop.userInteractionEnabled = NO;
    [super viewDidLoad];
    mainPath = [[UIBezierPath alloc]init];
    pointArray = [[NSMutableArray alloc]init];
    imgPicker = [[UIImagePickerController alloc] init];
	[imgPicker setDelegate:self];
	[imgPicker setWantsFullScreenLayout:YES];
    [imgPicker setAllowsEditing:NO];
    //ApplicationDelegate.navigationController.navigationBarHidden = TRUE;
    imgofpicker = [UIImage imageNamed:@"logo.png"];
    aImgView.image = [imgofpicker retain];	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [self setImvCroppedImage:nil];
    [self setImvOriginalImage:nil];
    [self setBtnCamera:nil];
    topLeftBtn = nil;
    topRightBtn = nil;
    bottomLeftBtn = nil;
    bottomRightBtn = nil;
    _buttonCamera = nil;
    _buttonLibrary = nil;
    _buttonOverlay = nil;
    _buttonTemplate = nil;
    _buttonSend = nil;
    _flexSpace = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - GestureHandler

// Select Image from Camera or Photo Library according to button tapped
- (IBAction)SelectImageFrom:(id)sender {
    objImgPicker = [[UIImagePickerController alloc] init];
    [objImgPicker setDelegate:self];
    if ([sender tag] == 1) {
        [objImgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [objImgPicker setShowsCameraControls:YES];
    }
    else
    {
        [objImgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [self presentModalViewController:objImgPicker animated:YES];
}


- (IBAction)SendImage:(id)sender {
    
    UIViewController *paymentView = [[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
    
    [[self navigationController] pushViewController:paymentView animated:YES];

}

-(void)registerDevice
{
    NSLog(@"registerDevice");
    MobileDeviceRegistrationRequest *registrationRequest=[MobileDeviceRegistrationRequest mobileDeviceRegistrationRequest];
    
    registrationRequest.anetApiRequest.merchantAuthentication.name= @"someone";
    
    registrationRequest.anetApiRequest.merchantAuthentication.password = @"someonepwd";
    
    registrationRequest.mobileDevice.mobileDescription=@"iPhone";
    registrationRequest.mobileDevice.phoneNumber = @"xxxxxxxx";
    registrationRequest.mobileDevice.mobileDeviceId=[[[UIDevice currentDevice] uniqueIdentifier]
                                                     stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
    NSLog(@"registrationRequest %@",registrationRequest);
    [AuthNet authNetWithEnvironment:ENV_TEST];
    
    AuthNet *an = [AuthNet getInstance];
    
    [an setDelegate:self];
    
    [an mobileDeviceRegistrationRequest:registrationRequest];
    
}


- (void) loginToGateway {
    MobileDeviceLoginRequest *mobileDeviceLoginRequest =
    [MobileDeviceLoginRequest mobileDeviceLoginRequest];
    mobileDeviceLoginRequest.anetApiRequest.merchantAuthentication.sessionToken =sessionToken;
    mobileDeviceLoginRequest.anetApiRequest.merchantAuthentication.name = @"someone";
    mobileDeviceLoginRequest.anetApiRequest.merchantAuthentication.password = @"somepwd";
    mobileDeviceLoginRequest.anetApiRequest.merchantAuthentication.mobileDeviceId =
    [[[UIDevice currentDevice] uniqueIdentifier]
     stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
    [AuthNet authNetWithEnvironment:ENV_TEST];
    AuthNet *an = [AuthNet getInstance];
    [an setDelegate:self];
    [an mobileDeviceLoginRequest: mobileDeviceLoginRequest];
}

- (void) createTransaction {
    //[AuthNet authNetWithEnvironment:ENV_TEST];
    AuthNet *an = [AuthNet getInstance];
    
    [an setDelegate:self];
    
    CreditCardType *creditCardType = [CreditCardType creditCardType];
    creditCardType.cardNumber = @"4111111111111111";
    creditCardType.cardCode = @"100";
    creditCardType.expirationDate = @"1214";
    
    PaymentType *paymentType = [PaymentType paymentType];
    paymentType.creditCard = creditCardType;
    
    ExtendedAmountType *extendedAmountTypeTax = [ExtendedAmountType extendedAmountType];
    extendedAmountTypeTax.amount = @"0";
    extendedAmountTypeTax.name = @"Tax";
    
    ExtendedAmountType *extendedAmountTypeShipping = [ExtendedAmountType extendedAmountType];
    extendedAmountTypeShipping.amount = @"0";
    extendedAmountTypeShipping.name = @"Shipping";
    
    LineItemType *lineItem = [LineItemType lineItem];
    lineItem.itemName = @"Soda";
    lineItem.itemDescription = @"Soda";
    lineItem.itemQuantity = @"1";
    lineItem.itemPrice = @"1.00";
    lineItem.itemID = @"1";
    
    TransactionRequestType *requestType = [TransactionRequestType transactionRequest];
    requestType.lineItems = [NSArray arrayWithObject:lineItem];
    requestType.amount = @"1.00";
    requestType.payment = paymentType;
    requestType.tax = extendedAmountTypeTax;
    requestType.shipping = extendedAmountTypeShipping;
    
    CreateTransactionRequest *request = [CreateTransactionRequest createTransactionRequest];
    request.transactionRequest = requestType;
    request.transactionType = AUTH_ONLY;
    request.anetApiRequest.merchantAuthentication.mobileDeviceId =
    [[[UIDevice currentDevice] uniqueIdentifier]
     stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
    request.anetApiRequest.merchantAuthentication.sessionToken = sessionToken;
    [an purchaseWithRequest:request];
}

- (void) requestFailed:(AuthNetResponse *)response {
    // Handle a failed request
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was in sending your order. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) connectionFailed:(AuthNetResponse *)response {
    // Handle a failed connection
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was in sending your order. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) paymentSucceeded:(CreateTransactionResponse *) response {
    // Handle payment success
    NSLog(@"Message Sent");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Order sent" message:@"Check your email for confirmation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void) mobileDeviceLoginSucceeded:(MobileDeviceLoginResponse *)response {
    sessionToken = [response.sessionToken retain];
    [self createTransaction];
};

-(void)sendEmail:(NSString*)_toEmailAddress {
    // create soft wait overlay so the user knows whats going on in the background.
    //[self createWaitOverlay];
    
    ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];
    
    SKPSMTPMessage *funnyOrder = [[SKPSMTPMessage alloc] init];
    [funnyOrder setFromEmail:@"someone"];  // Change to your email address
    [funnyOrder setToEmail:_toEmailAddress]; // Load this, or have user enter this
    [funnyOrder setRelayHost:@"smtp.gmail.com"];
    [funnyOrder setRequiresAuth:YES]; // GMail requires this
    [funnyOrder setLogin:@"someone"]; // Same as the "setFromEmail:" email
    [funnyOrder setPass:@"xxxxxx"]; // Password for the Gmail account that are sending from
    [funnyOrder setSubject:@"ImageEditor Order"]; // Change this to change the subject of the email
    [funnyOrder setWantsSecure:YES]; // Gmail Requires this
    [funnyOrder setDelegate:self]; // Required
    
    
    NSString *header = @"<h5>Order Info ";
    header = [header stringByAppendingFormat:@"</h5>"];
    
    NSString *tableFirstLine = @"<table width='300' border='1'><tr><td>Order No</td><td>12345</td></tr>";
    NSString *increments = @"";
    
    increments = [increments stringByAppendingFormat:header];
    increments = [increments stringByAppendingFormat:tableFirstLine];
    
    
    increments = [increments stringByAppendingFormat:@"<tr><td>"];
    increments = [increments stringByAppendingFormat:@"Name"];
    increments = [increments stringByAppendingFormat:@"</td><td>"];
    increments = [increments stringByAppendingFormat:@""];
    increments = [increments stringByAppendingFormat:@"</td><td>"];
    
    increments = [increments stringByAppendingFormat:@"<tr><td>"];
    increments = [increments stringByAppendingFormat:@"Address"];
    increments = [increments stringByAppendingFormat:@"</td><td>"];
    increments = [increments stringByAppendingFormat:@""];
    increments = [increments stringByAppendingFormat:@"</td><td>"];
    
    increments = [increments stringByAppendingFormat:@"<tr><td>"];
    increments = [increments stringByAppendingFormat:@"Phone"];
    increments = [increments stringByAppendingFormat:@"</td><td>"];
    increments = [increments stringByAppendingFormat:@""];
    increments = [increments stringByAppendingFormat:@"</td><td>"];
    
    increments = [increments stringByAppendingFormat:@"</table>"];
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/html", kSKPSMTPPartContentTypeKey, increments, kSKPSMTPPartMessageKey, @"8bit" , kSKPSMTPPartContentTransferEncodingKey, nil];
    
    
    NSData *imageData = UIImageJPEGRepresentation(imgSingleton.finalImage, 1.5);
    NSString *strFileName = [NSString stringWithFormat:@"MyImage.jpeg"];
    
    NSString *strFormat = [NSString stringWithFormat:@"image/jpeg;\r\n\tx-unix-mode=0644;\r\n\tname=\"%@\"",strFileName];
    NSString *strFormat2 = [NSString stringWithFormat:@"attachment;\r\n\tfilename=\"%@\"",strFileName];
    
    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:strFormat,kSKPSMTPPartContentTypeKey,
                             strFormat2,kSKPSMTPPartContentDispositionKey,[imageData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    
    
    funnyOrder.parts = [NSArray arrayWithObjects:vcfPart,
                        plainPart,
                        nil];
    
    
    [funnyOrder send];

    
}


- (void)messageSent:(SKPSMTPMessage *)message {
    NSLog(@"Message Sent");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Order sent" message:@"Check your email for confirmation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error {
    NSLog(@"Message Failed With Error(s): %@", [error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was in sending your order. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


- (IBAction)CropImages:(id)sender {
    
    UIViewController *templateView = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];
    
    [[self navigationController] pushViewController:templateView animated:YES];
    
}


- (IBAction)SelectTemplateFrom:(id)sender {
    
    UIViewController *templateView = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];
    
    [[self navigationController] pushViewController:templateView animated:YES];

}

- (IBAction)OverlayImages:(id)sender {
    
    UIViewController *overlayView = [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];
    
    [[self navigationController] pushViewController:overlayView animated:YES];
    
}

// Adding gestures on the buttons and creating crop view 
- (void)setViewForCropping {
       
    //Crop Image
    UIPanGestureRecognizer *panRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move1:)];
	[panRecognizer1 setMinimumNumberOfTouches:1];
	[panRecognizer1 setMaximumNumberOfTouches:1];
	[panRecognizer1 setDelegate:self];
	[topLeftBtn addGestureRecognizer:panRecognizer1];
  
    
    UIPanGestureRecognizer *panRecognizer2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move2:)];
	[panRecognizer2 setMinimumNumberOfTouches:1];
	[panRecognizer2 setMaximumNumberOfTouches:1];
	[panRecognizer2 setDelegate:self];
	[topRightBtn addGestureRecognizer:panRecognizer2];
  
    
    UIPanGestureRecognizer *panRecognizer3 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move3:)];
	[panRecognizer3 setMinimumNumberOfTouches:1];
	[panRecognizer3 setMaximumNumberOfTouches:1];
	[panRecognizer3 setDelegate:self];
    [bottomLeftBtn addGestureRecognizer:panRecognizer3];
  
    
    UIPanGestureRecognizer *panRecognizer4 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move4:)];
	[panRecognizer4 setMinimumNumberOfTouches:1];
	[panRecognizer4 setMaximumNumberOfTouches:1];
	[panRecognizer4 setDelegate:self];
    [bottomRightBtn addGestureRecognizer:panRecognizer4];
  
    
    croppedImageView = [[UIImageView alloc]init];
    croppedImageView.contentMode = UIViewContentModeScaleAspectFit;
    //  UIImage *resizedImage = photoEditView.image;
    croppedImageView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *panRecognizer5 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move5:)];
	[panRecognizer5 setMinimumNumberOfTouches:1];
	[panRecognizer5 setMaximumNumberOfTouches:1];
	[panRecognizer5 setDelegate:self];
    [croppedImageView addGestureRecognizer:panRecognizer5];
   

}

// Invoke when TopLeft Button get moved
-(void)move1:(id)sender {
	
    [croppedImageView removeFromSuperview];
    CGRect editViewFrame = imvOriginalImage.frame;
	
	[self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		
		topLeftX = [[sender view] center].x;
		topLeftY = [[sender view] center].y;
	}
	
	translatedPoint = CGPointMake(topLeftX+translatedPoint.x, topLeftY+translatedPoint.y);
	
	[[sender view] setCenter:translatedPoint];
    
    CGFloat finalX = translatedPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
    CGFloat finalY = translatedPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
    
    
    if(finalX < editViewFrame.origin.x+14) {
        finalX = editViewFrame.origin.x+14;
    }
    else if(finalX >topRightBtn.frame.origin.x-10) {
        
        finalX =topRightBtn.frame.origin.x-10;
    }
    
    if(finalY <editViewFrame.origin.y+15) {
        
        finalY =editViewFrame.origin.y+15;
    }
    
    else if(finalY > bottomLeftBtn.frame.origin.y-10) {
        
        finalY = bottomLeftBtn.frame.origin.y-10;
    }
    
    [[sender view] setCenter:CGPointMake(finalX, finalY)];
    
    CGRect temp = topRightBtn.frame;
    temp.origin.y =  topLeftBtn.frame.origin.y;
    topRightBtn.frame = temp;
    
    CGRect temp2 = bottomLeftBtn.frame;
    temp2.origin.x = topLeftBtn.frame.origin.x;
    bottomLeftBtn.frame = temp2;
    
    
    
    [croppedImageView setFrame:CGRectMake(topLeftBtn.frame.origin.x+11, topLeftBtn.frame.origin.y+11, topRightBtn.frame.origin.x-topLeftBtn.frame.origin.x+30,bottomRightBtn.frame.origin.y-topLeftBtn.frame.origin.y+30)];
    
    CGRect imageRect = croppedImageView.frame;
    CGImageRef imageRef = CGImageCreateWithImageInRect([image320x480 CGImage], imageRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    
    croppedImageView.image = cropped;
    imvCroppedImage.image = cropped;
    ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];
    imgSingleton.modImage = cropped;
    CGImageRelease(imageRef);
    [self.view addSubview:croppedImageView];
    
}

// Invoke when TopRight Button get moved
-(void)move2:(id)sender {
    CGRect editViewFrame = imvOriginalImage.frame;
    [croppedImageView removeFromSuperview];
	//[[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
	
	[self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		
		topRightX = [[sender view] center].x;
		topRightY = [[sender view] center].y;
	}
	
	translatedPoint = CGPointMake(topRightX+translatedPoint.x, topRightY+translatedPoint.y);
	
	[[sender view] setCenter:translatedPoint];
	
	//if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
    
    CGFloat finalX = translatedPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
    CGFloat finalY = translatedPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
    
    
    if(finalX < topLeftBtn.frame.origin.x+40) {
        finalX =topLeftBtn.frame.origin.x +40;
    }
    if(finalX > editViewFrame.size.width+editViewFrame.origin.x-16) {
        
        finalX =  editViewFrame.size.width+editViewFrame.origin.x-16;
    }
    
    if(finalY <editViewFrame.origin.y+15) {
        
        finalY =editViewFrame.origin.y+15;
    }
    
    else if(finalY > bottomRightBtn.frame.origin.y-10) {
        
        finalY =  bottomRightBtn.frame.origin.y-10;
    }
    
    
    //		[UIView beginAnimations:nil context:NULL];
    //		[UIView setAnimationDuration:0];
    //		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [[sender view] setCenter:CGPointMake(finalX, finalY)];
    //		[UIView commitAnimations];
    //	}
    
    CGRect temp = topLeftBtn.frame;
    temp.origin.y =  topRightBtn.frame.origin.y;
    topLeftBtn.frame = temp;
    
    CGRect temp2 = bottomRightBtn.frame;
    temp2.origin.x = topRightBtn.frame.origin.x;
    bottomRightBtn.frame = temp2;
    
    [croppedImageView setFrame:CGRectMake(topLeftBtn.frame.origin.x+11, topRightBtn.frame.origin.y+11, topRightBtn.frame.origin.x-topLeftBtn.frame.origin.x+30,bottomRightBtn.frame.origin.y-topRightBtn.frame.origin.y+30)];
    CGRect imageRect = croppedImageView.frame;
    CGImageRef imageRef = CGImageCreateWithImageInRect([image320x480 CGImage], imageRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    croppedImageView.image = [UIImage imageWithCGImage:cropped.CGImage];
    imvCroppedImage.image = croppedImageView.image;
    [self.view addSubview:croppedImageView];
    ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];
    imgSingleton.modImage = croppedImageView.image;
    
    
}

// Invoke when BottomLeft Button get moved
-(void)move3:(id)sender {
    CGRect editViewFrame = imvOriginalImage.frame;
    [croppedImageView removeFromSuperview];
	
	[self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		
		bottomLeftX = [[sender view] center].x;
		bottomLeftY = [[sender view] center].y;
	}
	
	translatedPoint = CGPointMake(bottomLeftX+translatedPoint.x, bottomLeftY+translatedPoint.y);
	
	[[sender view] setCenter:translatedPoint];
	
    CGFloat finalX = translatedPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
    CGFloat finalY = translatedPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
    
    
    
    if(finalX < editViewFrame.origin.x+14) {
        finalX =  editViewFrame.origin.x+14;
    }
    else if(finalX > topRightBtn.frame.origin.x-10) {
        
        finalX =topRightBtn.frame.origin.x-10;
    }
    
    if(finalY <topLeftBtn.frame.origin.y+40) {
        
        finalY =topLeftBtn.frame.origin.y+40;
    }
    
    else if(finalY > editViewFrame.size.height+editViewFrame.origin.y-17) {
        
        finalY = editViewFrame.size.height+editViewFrame.origin.y-17;
    }
    [[sender view] setCenter:CGPointMake(finalX, finalY)];
    
    CGRect temp = topLeftBtn.frame;
    temp.origin.x =  bottomLeftBtn.frame.origin.x;
    topLeftBtn.frame = temp;
    
    CGRect temp2 = bottomRightBtn.frame;
    temp2.origin.y = bottomLeftBtn.frame.origin.y;
    bottomRightBtn.frame = temp2;
    [croppedImageView setFrame:CGRectMake(topLeftBtn.frame.origin.x+11, topLeftBtn.frame.origin.y+11, topRightBtn.frame.origin.x-topLeftBtn.frame.origin.x+30,bottomRightBtn.frame.origin.y-topRightBtn.frame.origin.y+30)];
    
    
    CGRect imageRect = croppedImageView.frame;
    CGImageRef imageRef = CGImageCreateWithImageInRect([image320x480 CGImage], imageRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    croppedImageView.image = cropped;
    imvCroppedImage.image = croppedImageView.image;
    [self.view addSubview:croppedImageView];
    
    ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];
    imgSingleton.modImage = croppedImageView.image;
    
}

// Invoke when BottomRight Button get moved
-(void)move4:(id)sender {
    CGRect editViewFrame = imvOriginalImage.frame;
    [croppedImageView removeFromSuperview];
	[self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		
		bottomRightX = [[sender view] center].x;
		bottomRightY = [[sender view] center].y;
	}
	
	translatedPoint = CGPointMake(bottomRightX+translatedPoint.x, bottomRightY+translatedPoint.y);
	
	[[sender view] setCenter:translatedPoint];
	
    CGFloat finalX = translatedPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
    CGFloat finalY = translatedPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
    
    
    if(finalX < topLeftBtn.frame.origin.x+40 ) {
        finalX = topLeftBtn.frame.origin.x+40;
    }
    else if(finalX > editViewFrame.size.width+editViewFrame.origin.x-16) {
        
        finalX = editViewFrame.size.width+editViewFrame.origin.x-16;
    }
    
    if(finalY <topRightBtn.frame.origin.y+40) {
        
        finalY =topRightBtn.frame.origin.y+40;
    }
    
    else if(finalY > editViewFrame.size.height+editViewFrame.origin.y-17) {
        
        finalY = editViewFrame.size.height+editViewFrame.origin.y-17;
    }
    
    [[sender view] setCenter:CGPointMake(finalX, finalY)];
    
    CGRect temp = topRightBtn.frame;
    temp.origin.x =  bottomRightBtn.frame.origin.x;
    topRightBtn.frame = temp;
    
    CGRect temp2 = bottomLeftBtn.frame;
    temp2.origin.y = bottomRightBtn.frame.origin.y;
    bottomLeftBtn.frame = temp2;
    
    
    [croppedImageView setFrame:CGRectMake(topLeftBtn.frame.origin.x+11, topLeftBtn.frame.origin.y+11, topRightBtn.frame.origin.x-topLeftBtn.frame.origin.x+30,bottomRightBtn.frame.origin.y-topRightBtn.frame.origin.y+30)];
    
    CGRect imageRect = croppedImageView.frame;
    CGImageRef imageRef = CGImageCreateWithImageInRect([image320x480 CGImage], imageRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    croppedImageView.image = cropped;
    imvCroppedImage.image = croppedImageView.image;
    [self.view addSubview:croppedImageView];
    
    ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];
    imgSingleton.modImage = croppedImageView.image;
}

// Call when main imageview's image get change i.e imagePicker:didFinishPickingImage: method
-(void)cropImage
{
    [croppedImageView setFrame:CGRectMake(topLeftBtn.frame.origin.x+11, topLeftBtn.frame.origin.y+11, topRightBtn.frame.origin.x-topLeftBtn.frame.origin.x+30,bottomRightBtn.frame.origin.y-topRightBtn.frame.origin.y+30)];                                
    topLeftBtn.hidden = NO;
    topRightBtn.hidden = NO;
    bottomLeftBtn.hidden = NO;
    bottomRightBtn.hidden = NO;
    croppedImageView.hidden = NO;
    
    currentImage = imvOriginalImage.image;
    
    CGRect imageRect = CGRectMake(topLeftBtn.frame.origin.x+11, topLeftBtn.frame.origin.y+11, topRightBtn.frame.origin.x-topLeftBtn.frame.origin.x+30,bottomRightBtn.frame.origin.y-topRightBtn.frame.origin.y+30);
    
    
    CGSize mySize = CGSizeMake(726,1024);
    UIGraphicsBeginImageContext(mySize);
    
    [currentImage drawInRect:CGRectMake(imvOriginalImage.frame.origin.x,imvOriginalImage.frame.origin.y,imvOriginalImage.frame.size.width,imvOriginalImage.frame.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext(); 
    NSData *newData = UIImageJPEGRepresentation(newImage, 1.0);
    if (image320x480!=nil) {
        image320x480 = nil;
    }
    image320x480 = [[UIImage alloc]initWithData:newData];
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image320x480.CGImage, imageRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    croppedImageView.image = cropped;
    CGImageRelease(imageRef);
    [self move1:[[topLeftBtn gestureRecognizers] lastObject]];
}

-(void)move5:(id)sender {
	
    CGRect editViewFrame = imvOriginalImage.frame;
	[self.view bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
		
		imageX = [[sender view] center].x;
		imageY = [[sender view] center].y;
	}
	
	translatedPoint = CGPointMake(imageX+translatedPoint.x, imageY+translatedPoint.y);
	
	[[sender view] setCenter:translatedPoint];
    
    CGFloat finalX = translatedPoint.x + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].x);
    CGFloat finalY = translatedPoint.y + (0*[(UIPanGestureRecognizer*)sender velocityInView:self.view].y);
    CGFloat finalX2 = finalX+(croppedImageView.frame.size.width/2);
    CGFloat finalY2 = finalY+(croppedImageView.frame.size.height/2);
    
    if((finalX-(croppedImageView.frame.size.width/2))   < editViewFrame.origin.x+5 ) {
        finalX = editViewFrame.origin.x+(croppedImageView.frame.size.width/2);
    }
    else if(finalX2 > editViewFrame.size.width+editViewFrame.origin.x) {
        
        finalX = editViewFrame.size.width+editViewFrame.origin.x-(croppedImageView.frame.size.width/2);
    }
    
    if(finalY-(croppedImageView.frame.size.height/2) <editViewFrame.origin.y) {
        
        finalY =editViewFrame.origin.y+(croppedImageView.frame.size.height/2);
    }
    
    else if(finalY2 > editViewFrame.size.height+editViewFrame.origin.y) {
        
        finalY = editViewFrame.size.height+editViewFrame.origin.y-(croppedImageView.frame.size.height/2);
    }
    
    [[sender view] setCenter:CGPointMake(finalX, finalY)];
    CGRect imageViewRect = croppedImageView.frame;
    [topLeftBtn setFrame:CGRectMake(imageViewRect.origin.x-11, imageViewRect.origin.y-11, 50, 50)];
    [topRightBtn setFrame:CGRectMake(imageViewRect.origin.x+imageViewRect.size.width-39, imageViewRect.origin.y-11, 50, 50)];
    [bottomLeftBtn setFrame:CGRectMake(imageViewRect.origin.x-11,imageViewRect.origin.y+imageViewRect.size.height-39 ,50, 50)];
    [bottomRightBtn setFrame:CGRectMake(imageViewRect.origin.x+imageViewRect.size.width-39, imageViewRect.origin.y+imageViewRect.size.height-39, 50, 50)];
    
    CGRect imageRect = croppedImageView.frame;
    CGImageRef imageRef = CGImageCreateWithImageInRect([image320x480 CGImage], imageRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    croppedImageView.image = cropped;
    imvCroppedImage.image = croppedImageView.image;
    ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];
    imgSingleton.modImage = croppedImageView.image;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    CGImageRef imgRef = [[self imageWithRotation:image] CGImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    [imvOriginalImage setImage:img];
    [self dismissModalViewControllerAnimated:YES];
    [self cropImage];
}

// Rotating Image
- (UIImage*)imageWithRotation:(UIImage*)image {
    CGImageRef imageRef = [image CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
    
    CGContextRef bitmap;
    if (image.imageOrientation == UIImageOrientationUp || image.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, image.size.width, image.size.height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    }
    else
    {
         bitmap = CGBitmapContextCreate(NULL, image.size.height, image.size.width, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    }
    if (image.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -image.size.height);
        
    } else if (image.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -image.size.width, 0);
        
    } else if (image.imageOrientation == UIImageOrientationUp) {
        // NOTHING
    } else if (image.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, image.size.width, image.size.height);
        CGContextRotateCTM (bitmap, radians(-180.));
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage; 
}

// new

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   if(btnClearCrop.isUserInteractionEnabled == YES)
        return;
    UITouch *touch = [touches anyObject];
    self.location = [touch locationInView:aImgView];
    startCGPoint = self.location;
    [mainPath moveToPoint:startCGPoint];
    
    [pointArray addObject:[NSString stringWithFormat:@"%f,%f",startCGPoint.x,startCGPoint.y]];
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(btnClearCrop.isUserInteractionEnabled == YES)
        return;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:aImgView];
    UIGraphicsBeginImageContext(aImgView.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [aImgView.image drawInRect:CGRectMake(0, 0, aImgView.frame.size.width, aImgView.frame.size.height)];
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //CGContextSetBlendMode(ctx, kCGBlendModeClear);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, location.x, location.y);
    CGContextAddLineToPoint(ctx, currentLocation.x, currentLocation.y);
    CGContextStrokePath(ctx);
    aImgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    location = currentLocation;
    [mainPath addLineToPoint:location];
    [pointArray addObject:[NSString stringWithFormat:@"%f,%f",location.x,location.y]];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(btnClearCrop.isUserInteractionEnabled == YES)
        return;
    
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:aImgView];
    UIGraphicsBeginImageContext(aImgView.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [aImgView.image drawInRect:CGRectMake(0, 0, aImgView.frame.size.width, aImgView.frame.size.height)];
    
    //CGContextSetBlendMode(ctx, kCGBlendModeClear);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, location.x, location.y);
    CGContextAddLineToPoint(ctx, currentLocation.x, currentLocation.y);
    CGContextStrokePath(ctx);
    aImgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    location = currentLocation;
    
    [pointArray addObject:[NSString stringWithFormat:@"%f,%f",location.x,location.y]];
    
    UIGraphicsBeginImageContext(aImgView.frame.size);
    CGContextRef ct = UIGraphicsGetCurrentContext();
    [aImgView.image drawInRect:CGRectMake(0, 0, aImgView.frame.size.width, aImgView.frame.size.height)];
    //CGContextSetBlendMode(ct, kCGBlendModeClear);
    CGContextSetLineCap(ct, kCGLineCapRound);
    CGContextSetLineWidth(ct, 2.0);
    CGContextSetRGBStrokeColor(ct, 1.0, 1.0, 1.0, 1.0);
    CGContextBeginPath(ct);
    CGContextMoveToPoint(ct, location.x, location.y);
    CGContextAddLineToPoint(ct, startCGPoint.x, startCGPoint.y);
    CGContextStrokePath(ct);
    aImgView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [mainPath addLineToPoint:startCGPoint];
}


#pragma mark - Image Crop

-(UIImage*)CropImage:(UIBezierPath *)trackPath{
    [btnClearCrop setUserInteractionEnabled:YES];
    [btnCrop setUserInteractionEnabled:NO];
    CGContextRef mainViewContentContext;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a bitmap graphics context the size of the image
    mainViewContentContext = CGBitmapContextCreate(NULL, aImgView.frame.size.width, aImgView.frame.size.height, 8,  aImgView.frame.size.width*4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);
    
    //Translate and scale image
    CGContextTranslateCTM(mainViewContentContext, 0, aImgView.frame.size.height);
    CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
    
    //the mask
    CGContextAddPath(mainViewContentContext, trackPath.CGPath);
    CGContextClip(mainViewContentContext);
    
    //Translate and scale image
    CGContextTranslateCTM(mainViewContentContext, 0, aImgView.frame.size.height);
    CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
    
    //the main image
    CGContextDrawImage(mainViewContentContext, CGRectMake(0, 0, aImgView.frame.size.width, aImgView.frame.size.height), aImgView.image.CGImage);
    
    //the outline
    CGContextSetLineWidth(mainViewContentContext, 1);
    CGContextSetRGBStrokeColor(mainViewContentContext, 181.0/256, 181.0/256, 181.0/256, 1.0);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    
    // convert the finished resized image to a UIImage
    UIImage *newImage = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    
    // image is retained by the property setting above, so we can
    // release the original
    CGImageRelease(mainViewContentBitmapContext);
    
    return newImage;
}

#pragma mark - Control Method

-(IBAction)btnCropImage:(id)sender{
    float intMinX = self.view.frame.size.width;
    float intMaxX = 0;
    float intMinY = self.view.frame.size.height;
    float intMaxY = 0;
    if([pointArray count]){
        for (int i=0;i<[pointArray count];i++) {
            NSString *str =[pointArray objectAtIndex:i];
            NSArray *tempArray = [str componentsSeparatedByString:@","];
            int intX = [[tempArray objectAtIndex:0]integerValue];
            int intY = [[tempArray objectAtIndex:1] integerValue];
            if(intX < intMinX){
                intMinX = intX;
            }
            if (intX>intMaxX) {
                intMaxX=intX;
            }
            
            if(intY < intMinY){
                intMinY = intY;
            }
            if (intY>intMaxY) {
                intMaxY=intY;
            }
        }
        CGSize newSize=CGSizeMake(intMaxX-intMinX,intMaxY-intMinY);
        UIImage* tempImage = [self CropImage:mainPath];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"image1.png"]];
        NSData *imgData = UIImageJPEGRepresentation(tempImage, 0.5);
        if(imgData){
            [imgData writeToFile:filePath atomically:YES];
        }
        CGImageRef imageRef = CGImageCreateWithImageInRect([tempImage CGImage], CGRectMake(intMinX, intMinY, newSize.width, newSize.height));
        aImgView.frame = CGRectMake(intMinX,intMinY+44,newSize.width,newSize.height);
        
        UIImage* newImage = [UIImage imageWithCGImage:imageRef];
        aImgView.image = newImage;
        filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"image2.png"]];
        imgData = UIImageJPEGRepresentation(newImage, 0.5);
        if(imgData){
            [imgData writeToFile:filePath atomically:YES];
        }
        [pointArray removeAllObjects];
    }else{
        UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"Alert" message:@"Please select path for crop" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
}

-(IBAction)btnOriginalImage:(id)sender{
    [btnClearCrop setUserInteractionEnabled:NO];
    [btnCrop setUserInteractionEnabled:YES];
    /*if(isIphone5()){
        aImgView.frame = CGRectMake(0, 50, 320, 450 + isIphone5OffSet());
    }else{
        aImgView.frame = CGRectMake(0, 50, 320, 430);
    }*/
    aImgView.image = imgofpicker;
    [mainPath removeAllPoints];
}


@end
