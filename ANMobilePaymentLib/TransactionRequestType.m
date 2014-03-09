//
//  TransactionRequestType.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import "TransactionRequestType.h"
#import "NSString+stringWithXMLTag.h"


@implementation TransactionRequestType

@synthesize transactionType;
@synthesize amount;
@synthesize payment;
@synthesize authCode;
@synthesize refTransId;
@synthesize splitTenderId;
@synthesize order;
@synthesize lineItems;
@synthesize tax;
@synthesize duty;
@synthesize shipping;
@synthesize taxExempt;
@synthesize poNumber;
@synthesize customer;
@synthesize billTo;
@synthesize shipTo;
@synthesize customerIP;
@synthesize retail;
@synthesize transactionSettings;
@synthesize userFields;

+ (TransactionRequestType *) transactionRequest {
    TransactionRequestType *t = [[[TransactionRequestType alloc] init] autorelease];
    return t;
}

- (id) init {
    self = [super init];
    if (self) {
        self.transactionType = nil;
        self.amount = nil;
        self.payment = [PaymentType paymentType];
        self.authCode = nil;
        self.refTransId = nil;
        self.splitTenderId = nil;
        self.order = [OrderType order];
        self.lineItems = [NSMutableArray array];
        self.tax = [ExtendedAmountType extendedAmountType];
        self.duty = [ExtendedAmountType extendedAmountType];
        self.shipping = [ExtendedAmountType extendedAmountType];
        self.taxExempt = nil;
        self.poNumber = nil;
        self.customer = [CustomerDataType customerDataType];
        self.billTo = [CustomerAddressType customerAddressType];
        self.shipTo = [NameAndAddressType nameAndAddressType];
        self.customerIP = nil;
        self.retail = [TransRetailInfoType transRetailInfoType];
        self.transactionSettings = [NSMutableArray array];
        self.userFields = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
    self.transactionType = nil;
    self.amount = nil;
    self.payment = nil;
    self.authCode = nil;
    self.refTransId = nil;
    self.splitTenderId = nil;
    self.order = nil;
    self.lineItems = nil;
    self.tax = nil;
    self.duty = nil;
    self.shipping = nil;
    self.taxExempt = nil;
    self.poNumber = nil;
    self.customer = nil;
    self.billTo = nil;
    self.shipTo = nil;
    self.customerIP = nil;
    self.retail = nil;
    self.transactionSettings = nil;
    self.userFields = nil;
    [super dealloc];
}

- (NSString *) description {
    NSString *output = [NSString stringWithFormat:@""
                        @"self.transactionType = %@"
                        @"self.amount = %@"
                        @"self.payment = %@"
                        @"self.authCode = %@"
                        @"self.refTransId = %@"
                        @"self.splitTenderId = %@"
                        @"self.order = %@"
                        @"self.lineItems = %@"
                        @"self.tax = %@"
                        @"self.duty = %@"
                        @"self.shipping = %@"
                        @"self.taxExempt = %@"
                        @"self.poNumber = %@"
                        @"self.customer = %@"
                        @"self.billTo = %@"
                        @"self.shipTo = %@"
                        @"self.customerIP = %@"
                        @"self.retail = %@"
                        @"self.transactionSettings = %@"
                        @"self.userFields = %@",
                        self.transactionType,
                        self.amount,
                        self.payment,
                        self.authCode,
                        self.refTransId,
                        self.splitTenderId,
                        self.order,
                        self.lineItems,
                        self.tax,
                        self.duty,
                        self.shipping,
                        self.taxExempt,
                        self.poNumber,
                        self.customer,
                        self.billTo,
                        self.shipTo,
                        self.customerIP,
                        self.retail,
                        self.transactionSettings,
                        self.userFields];
    return output;
}

- (NSString *)stringOfXMLRequest {
    
    // create the lineItem XML
    NSString *ls = [NSMutableString string];
    for (LineItemType *l in self.lineItems) {
        ls = [ls stringByAppendingFormat:@"%@", [l stringOfXMLRequest]];
    }
        
    // create the transactionSettings XML
    NSString *ts = [NSMutableString string];
    for (SettingType *s in self.transactionSettings) {
        ts = [ts stringByAppendingFormat:@"%@", [s stringOfXMLRequest]];
    }
    
    // create the userFields XML
    NSString *us = [NSMutableString string];
    for (UserField *u in self.userFields) {
        us = [us stringByAppendingFormat:@"%@", [u stringOfXMLRequest]];
    }
    
    
    NSString *s = [NSString stringWithFormat:@""
                   @"<transactionRequest>"
                        @"%@"       //transactionType
                        @"%@"       //amount,
                        @"%@"       //payment,
                        @"%@"       //authCode,
                        @"%@"       //refTransId,
                        @"%@"       //splitTenderId,
                        @"%@"       //order,
                        @"<lineItems>%@</lineItems>"       //lineItems,
                        @"%@"       //tax,
                        @"%@"       //duty,
                        @"%@"       //shipping,
                        @"%@"       //taxExempt,
                        @"%@"       //poNumber,
                        @"%@"       //customer,
                        @"<billTo>%@</billTo>"       //billTo,
                        @"<shipTo>%@</shipTo>"       //shipTo,
                        @"%@"       //customerIP,
                        @"%@"       //retail,
                        @"<transactionSettings>%@</transactionSettings>" //transactionSettings,
                        @"<userFields>%@</userFields>"       //userFields
                   @"</transactionRequest>",
                   [NSString stringWithXMLTag:@"transactionType" andValue:self.transactionType],
                   [NSString stringWithXMLTag:@"amount" andValue:self.amount],
                   (self.payment ? [self.payment stringOfXMLRequest] : @""),
                   [NSString stringWithXMLTag:@"authCode" andValue:self.authCode],
                   [NSString stringWithXMLTag:@"refTransId" andValue:self.refTransId],
                   [NSString stringWithXMLTag:@"splitTenderId" andValue:self.splitTenderId],
                   [self.order stringOfXMLRequest],
                   ls,
                   (self.tax.amount ? [NSString stringWithFormat:@"<tax>%@</tax>", [self.tax stringOfXMLRequest]] : @""),
                   (self.duty.amount ? [NSString stringWithFormat:@"<duty>%@</duty>", [self.duty stringOfXMLRequest]] : @""),
                   (self.shipping.amount ? [NSString stringWithFormat:@"<shipping>%@</shipping>", [self.shipping stringOfXMLRequest]] : @""),
                   [NSString stringWithXMLTag:@"taxExempt" andValue:self.taxExempt],
                   [NSString stringWithXMLTag:@"poNumber" andValue:self.poNumber],
                   [self.customer stringOfXMLRequest],
                   [self.billTo stringOfXMLRequest],
                   [self.shipTo stringOfXMLRequest],
                   [NSString stringWithXMLTag:@"customerIP" andValue:self.customerIP],
                   (retail.marketType ? [NSString stringWithFormat:@"<retail>%@</retail>", [self.retail stringOfXMLRequest]] : @""),
                   ts,
                   us];
    
    return s;
                   
}
@end
