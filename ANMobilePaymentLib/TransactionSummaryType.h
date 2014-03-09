//
//  TransactionSummaryType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/24/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface TransactionSummaryType : NSObject {
    NSString *transId;
    NSString *submitTimeUTC;
    NSString *submitTimeLocal;
    NSString *transactionStatus;
    NSString *invoiceNumber;
    NSString *firstName;
    NSString *lastName;
    NSString *accountType;
    NSString *accountNumber;
    NSString *settleAmount;
}

@property (nonatomic, retain) NSString *transId;
@property (nonatomic, retain) NSString *submitTimeUTC;
@property (nonatomic, retain) NSString *submitTimeLocal;
@property (nonatomic, retain) NSString *transactionStatus;
@property (nonatomic, retain) NSString *invoiceNumber;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *accountType;
@property (nonatomic, retain) NSString *accountNumber;
@property (nonatomic, retain) NSString *settleAmount;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (TransactionSummaryType *) transactionSummaryType;

/**
 * TransactionSummaryType from parsing the XML response indexed by GDataXMLElement
 * @return TransactionSummaryType autorelease instance of the parser generated object.
 */
+ (TransactionSummaryType *) buildTransactionSummaryType:(GDataXMLElement *)element;
@end
