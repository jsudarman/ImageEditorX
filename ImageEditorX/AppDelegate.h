//
//  AppDelegate.h
//  ImageEditorX
//
//  Created by IndiaNIC_08 on 03/05/12.
//  Copyright (c) 2012 IndiaNIC Infotech Ltd All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
//@class TemplateViewController;
//@class MailsViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
//@property (strong, nonatomic) TemplateViewController *templateViewController;
//@property (strong, nonatomic) MailsViewController *mailView;

@property (nonatomic, retain) UINavigationController *navController;

@end
