//
//  BankAccountType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BankAccountType : NSObject {
    NSString *accountType;
    NSString *routingNumber;
    NSString *accountNumber;
    NSString *nameOnAccount;
    NSString *echeckType;
    NSString *checkNumber;
}

@property (nonatomic, retain) NSString *accountType;
@property (nonatomic, retain) NSString *routingNumber;
@property (nonatomic, retain) NSString *accountNumber;
@property (nonatomic, retain) NSString *nameOnAccount;
@property (nonatomic, retain) NSString *echeckType;
@property (nonatomic, retain) NSString *checkNumber;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (BankAccountType *) bankAccountType;

/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *) stringOfXMLRequest;
@end
