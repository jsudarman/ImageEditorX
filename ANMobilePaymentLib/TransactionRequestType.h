//
//  TransactionRequestType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentType.h"
#import "ExtendedAmountType.h"
#import "CustomerDataType.h"
#import "CustomerAddressType.h"
#import "LineItemType.h"
#import "NameAndAddressType.h"
#import "OrderType.h"
#import "SettingType.h"
#import "TransRetailInfoType.h"
#import "UserField.h"

@interface TransactionRequestType : NSObject {
    NSString *transactionType;
    NSString *amount;
    PaymentType *payment;
    NSString *authCode;
    NSString *refTransId;
    NSString *splitTenderId;
    OrderType *order;
    NSMutableArray *lineItems;
    ExtendedAmountType *tax;
    ExtendedAmountType *duty;
    ExtendedAmountType *shipping;
    NSString *taxExempt;
    NSString *poNumber;
    CustomerDataType *customer;
    CustomerAddressType *billTo;
    NameAndAddressType *shipTo;
    NSString *customerIP;
    TransRetailInfoType *retail;
    NSMutableArray *transactionSettings;
    NSMutableArray *userFields;

}


@property (nonatomic, retain) NSString *transactionType;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) PaymentType *payment;
@property (nonatomic, retain) NSString *authCode;
@property (nonatomic, retain) NSString *refTransId;
@property (nonatomic, retain) NSString *splitTenderId;
@property (nonatomic, retain) OrderType *order;
@property (nonatomic, retain) NSMutableArray *lineItems;
@property (nonatomic, retain) ExtendedAmountType *tax;
@property (nonatomic, retain) ExtendedAmountType *duty;
@property (nonatomic, retain) ExtendedAmountType *shipping;
@property (nonatomic, retain) NSString *taxExempt;
@property (nonatomic, retain) NSString *poNumber;
@property (nonatomic, retain) CustomerDataType *customer;
@property (nonatomic, retain) CustomerAddressType *billTo;
@property (nonatomic, retain) NameAndAddressType *shipTo;
@property (nonatomic, retain) NSString *customerIP;
@property (nonatomic, retain) TransRetailInfoType *retail;
@property (nonatomic, retain) NSMutableArray *transactionSettings;
@property (nonatomic, retain) NSMutableArray *userFields;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (TransactionRequestType *) transactionRequest;

/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *)stringOfXMLRequest;
@end
