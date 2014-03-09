//
//  TransactionResponse.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 1/17/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Messages.h"
#import "GDataXMLNode.h"
#import "SplitTenderPayment.h"
#import "UserField.h"
#import "Error.h"

@interface TransactionResponse : NSObject {

	NSString *responseCode;
	NSString *authCode;
	NSString *avsResultCode;
	NSString *cvvResultCode;
	NSString *cavvResultCode;
	NSString *transId;
	NSString *refTransID;
	NSString *transHash;
	NSString *testRequest;
	NSString *accountNumber;
	NSString *accountType;
    NSString *splitTenderId;
	Messages *messages;
	NSMutableArray *errors;
	SplitTenderPayment *splitTenderPayment;
	NSMutableArray *userFields;
}

@property (nonatomic, retain) NSString *responseCode;
@property (nonatomic, retain) NSString *authCode;
@property (nonatomic, retain) NSString *avsResultCode;
@property (nonatomic, retain) NSString *cvvResultCode;
@property (nonatomic, retain) NSString *cavvResultCode;
@property (nonatomic, retain) NSString *transId;
@property (nonatomic, retain) NSString *refTransID;
@property (nonatomic, retain) NSString *transHash;
@property (nonatomic, retain) NSString *testRequest;
@property (nonatomic, retain) NSString *accountNumber;
@property (nonatomic, retain) NSString *accountType;
@property (nonatomic, retain) NSString *splitTenderId;
@property (nonatomic, retain) Messages *messages;
@property (nonatomic, retain) NSMutableArray *errors;
@property (nonatomic, retain) SplitTenderPayment *splitTenderPayment;
@property (nonatomic, retain) NSMutableArray *userFields;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (TransactionResponse *) transactionResponse;

/**
 * TransactionResponse from parsing the XML response indexed by GDataXMLElement
 * @return TransactionResponse autorelease instance of the parser generated object.
 */
+ (TransactionResponse *) buildTransactionResponse:(GDataXMLElement *)element;
@end
