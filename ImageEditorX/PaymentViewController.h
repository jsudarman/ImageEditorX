//
//  PaymentViewController.h
//  ImageEditorX
//
//  Created by Judiandar Sudarman on 12/3/13.
//
//

#import <UIKit/UIKit.h>
#import "STPView.h"

@interface PaymentViewController : UIViewController <STPViewDelegate>

@property STPView* checkoutView;

@end
