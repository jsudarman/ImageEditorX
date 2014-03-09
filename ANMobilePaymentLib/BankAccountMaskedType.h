//
//  BankAccountMaskedType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/22/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface BankAccountMaskedType : NSObject {
    NSString *accountType;
    NSString *routingNumber;
    NSString *accountNumber;
    NSString *nameOnAccount;
    NSString *echeckType;
    NSString *bankName;
}

@property (nonatomic, retain) NSString *accountType;
@property (nonatomic, retain) NSString *routingNumber;
@property (nonatomic, retain) NSString *accountNumber;
@property (nonatomic, retain) NSString *nameOnAccount;
@property (nonatomic, retain) NSString *echeckType;
@property (nonatomic, retain) NSString *bankName;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (BankAccountMaskedType *) bankAccountMaskedType;

/**
 * Class method that takes in GDataXMLElement and returns a fully parsed
 * BankAccountMaskedType.  If the method was not able to parse the response,
 * a nil object is returned.
 * @return The parsed BankAccountMaskedType from parsing the GDataXMLElement or nil if unable
 * to parse the data.
 */
+ (BankAccountMaskedType *) buildBankAccountMaskedType:(GDataXMLElement *)element;
@end
