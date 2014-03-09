//
//  PaymentType.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import "PaymentType.h"
#import "NSString+stringWithXMLTag.h"


@implementation PaymentType

@synthesize creditCard;
@synthesize bankAccount;
@synthesize trackData;

+ (PaymentType *) paymentType {
    PaymentType *p = [[[PaymentType alloc] init] autorelease];
    return p;
}

- (id) init {
    self = [super init];
    if (self) {
        self.creditCard = [CreditCardType creditCardType];
        self.bankAccount = [BankAccountType bankAccountType];
        self.trackData = [CreditCardTrackType creditCardTrackType];
    }
    return self;
}

- (void) dealloc {
    self.creditCard = nil;
    self.bankAccount = nil;
    self.trackData = nil; 
    [super dealloc];
}

- (NSString *) description {
    NSString *output = [NSString stringWithFormat:@""
                        @"self.creditCard = %@"
                        @"self.bankAccount = %@"
                        @"self.trackData = %@",
                        self.creditCard,
                        self.bankAccount,
                        self.trackData];
    return output;
}

- (NSString *) stringOfXMLRequest {

    if (creditCard.cardNumber) {
        self.bankAccount = nil;
        self.trackData = nil;
    } 
    else if (bankAccount.accountNumber) {
        self.creditCard = nil;
        self.trackData = nil;
    }
    else if (trackData.track1 || trackData.track2) {
        self.creditCard = nil;
        self.bankAccount = nil;
    }
    
    NSString *s = [NSString stringWithFormat:@""
                   @"<payment>"
                        @"%@"       //creditCard
                        @"%@"       //bankAccount
                        @"%@"       //trackData
                   @"</payment>",
                   (self.creditCard ? [self.creditCard stringOfXMLRequest] : @""),
                   (self.bankAccount ? [self.bankAccount stringOfXMLRequest] : @""),
                   (self.trackData ? [self.trackData stringOfXMLRequest] : @"")];
    return s;
}
@end
