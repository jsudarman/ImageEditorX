//
//  TransactionDetailsType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/21/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BatchDetailsType.h"
#import "CCAuthenticationType.h"
#import "CustomerAddressType.h"
#import "CustomerDataType.h"
#import "ExtendedAmountType.h"
#import "NameAndAddressType.h"
#import "PaymentMaskedType.h"
#import "OrderType.h"

@interface TransactionDetailsType : NSObject {
    NSString *transId;
    NSString *refTransId;
    NSString *splitTenderId;
    NSString *submitTimeUTC;
    NSString *submitTimeLocal;
    
	NSString *transactionType;
	NSString *transactionStatus;
	NSString *responseCode;
	NSString *responseReasonCode;
	NSString *responseReasonDescription;
	NSString *authCode;
	NSString *AVSResponse;
	NSString *cardCodeResponse;
	NSString *CAVVResponse;
	
	NSString *FDSFilterAction;
	NSMutableArray *FDSFilters;
    
	BatchDetailsType *batchDetails;
	OrderType *order;
    
	NSString *requestedAmount;
	NSString *authAmount;
	NSString *settleAmount;
	
	ExtendedAmountType *tax;
	ExtendedAmountType *shipping;
	ExtendedAmountType *duty;
	
	NSMutableArray *lineItems;
	NSString *prepaidBalanceRemaining;
  	NSString *taxExempt;
	PaymentMaskedType *payment;
	CustomerDataType *customer;
    CustomerAddressType *billTo;
    NameAndAddressType *shipTo;
	NSString *recurringBilling;
	NSString *customerIP;
    CCAuthenticationType *cardholderAuthentication;
    
}

@property (nonatomic, retain) NSString *transId;
@property (nonatomic, retain) NSString *refTransId;
@property (nonatomic, retain) NSString *splitTenderId;
@property (nonatomic, retain) NSString *submitTimeUTC;
@property (nonatomic, retain) NSString *submitTimeLocal;

@property (nonatomic, retain) NSString *transactionType;
@property (nonatomic, retain) NSString *transactionStatus;
@property (nonatomic, retain) NSString *responseCode;
@property (nonatomic, retain) NSString *responseReasonCode;
@property (nonatomic, retain) NSString *responseReasonDescription;
@property (nonatomic, retain) NSString *authCode;
@property (nonatomic, retain) NSString *AVSResponse;
@property (nonatomic, retain) NSString *cardCodeResponse;
@property (nonatomic, retain) NSString *CAVVResponse;
@property (nonatomic, retain) NSString *FDSFilterAction;
@property (nonatomic, retain) NSMutableArray *FDSFilters;
@property (nonatomic, retain) BatchDetailsType *batchDetails;
@property (nonatomic, retain) OrderType *order;
@property (nonatomic, retain) NSString *requestedAmount;
@property (nonatomic, retain) NSString *authAmount;
@property (nonatomic, retain) NSString *settleAmount;
@property (nonatomic, retain) ExtendedAmountType *tax;
@property (nonatomic, retain) ExtendedAmountType *shipping;
@property (nonatomic, retain) ExtendedAmountType *duty;
@property (nonatomic, retain) NSMutableArray *lineItems;
@property (nonatomic, retain) NSString *prepaidBalanceRemaining;
@property (nonatomic, retain) NSString *taxExempt;
@property (nonatomic, retain) PaymentMaskedType *payment;
@property (nonatomic, retain) CustomerDataType *customer;
@property (nonatomic, retain) CustomerAddressType *billTo;
@property (nonatomic, retain) NameAndAddressType *shipTo;
@property (nonatomic, retain) NSString *recurringBilling;
@property (nonatomic, retain) NSString *customerIP;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (TransactionDetailsType *)transactionDetails;

/**
 * TransactionDetailsType from parsing the XML response indexed by GDataXMLElement
 * @return TransactionDetailsType autorelease instance of the parser generated object.
 */
+ (TransactionDetailsType *) buildTransactionDetails:(GDataXMLElement *)element;
@end
