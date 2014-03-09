//
//  SplitTenderPayment.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 1/28/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface SplitTenderPayment : NSObject {

	NSString *transId;
	NSString *responseCode;
	NSString *responseToCustomer;
	NSString *authCode;
	NSString *accountNumber;
	NSString *accountType;
	NSString *requestedAmount;
	NSString *approvedAmount;
	NSString *balanceOnCard;
}

@property (nonatomic, retain) NSString *transId;
@property (nonatomic, retain) NSString *responseCode;
@property (nonatomic, retain) NSString *responseToCustomer;
@property (nonatomic, retain) NSString *authCode;
@property (nonatomic, retain) NSString *accountNumber;
@property (nonatomic, retain) NSString *accountType;
@property (nonatomic, retain) NSString *requestedAmount;
@property (nonatomic, retain) NSString *approvedAmount;
@property (nonatomic, retain) NSString *balanceOnCard;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (SplitTenderPayment *) splitTenderPayment;

/**
 * SplitTenderPayment from parsing the XML response indexed by GDataXMLElement
 * @return SplitTenderPayment autorelease instance of the parser generated object.
 */
+ (SplitTenderPayment *)buildSplitTenderPayment:(GDataXMLElement *)element;
@end
