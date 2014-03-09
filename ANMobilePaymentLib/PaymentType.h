//
//  PaymentType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditCardType.h"
#import "BankAccountType.h"
#import "CreditCardTrackType.h"

@interface PaymentType : NSObject {
    CreditCardType *creditCard;
    BankAccountType *bankAccount;
    CreditCardTrackType *trackData;
}

// Only fill out one payment type
@property (nonatomic, retain) CreditCardType *creditCard;
@property (nonatomic, retain) BankAccountType *bankAccount;
@property (nonatomic, retain) CreditCardTrackType *trackData;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (PaymentType *) paymentType;

/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *) stringOfXMLRequest;

@end
