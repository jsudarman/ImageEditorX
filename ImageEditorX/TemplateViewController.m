//
//  TemplateViewController.m
//  ImageEditorX
//
//  Created by Judiandar Sudarman on 10/29/13.
//
//

#import "TemplateViewController.h"
#import "ImageSingleton.h"

@interface TemplateViewController ()

@end

@implementation TemplateViewController

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
    //add the scrollview to the view
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height)];
    self.scrollView.pagingEnabled = YES;
    [self.scrollView setAlwaysBounceVertical:NO];
    //setup internal views
    NSInteger numberOfViews = 2;
    for (int i = 0; i < numberOfViews; i++) {
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:
                              CGRectMake(xOrigin, 0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:
                                           @"image%d", i+1]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:image];
        ImageSingleton *imgSingleton = [ImageSingleton sharedSingleton];
        imgSingleton.templateImage = image.image;
    }
    //set the scroll view content size
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width *
                                             numberOfViews,
                                             self.view.frame.size.height);
    //add the scrollview to this view
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
