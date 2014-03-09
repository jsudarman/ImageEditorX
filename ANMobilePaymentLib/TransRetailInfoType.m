//
//  TransRetailInfoType.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import "TransRetailInfoType.h"
#import "NSString+stringWithXMLTag.h"

NSString * const MARKET_TYPE_RETAIL = @"2";

NSString * const DEVICE_TYPE_UNKNOWN = @"1";
NSString * const DEVICE_TYPE_UNATTENDED = @"2";
NSString * const DEVICE_TYPE_SELF_SERVICE_TERMINAL = @"3";
NSString * const DEVICE_TYPE_ELECTRONIC_CASH_REGISTER = @"4";
NSString * const DEVICE_TYPE_PERSONAL_COMPUTER_BASED_TERMINAL = @"5";
NSString * const DEVICE_TYPE_AIRPAY = @"6";
NSString * const DEVICE_TYPE_WIRELESS_POS = @"7";
NSString * const DEVICE_TYPE_WEBSITE = @"8";
NSString * const DEVICE_TYPE_DIAL_TERMINAL = @"9";
NSString * const DEVICE_TYPE_VIRTUAL_TERMINAL = @"10";

@implementation TransRetailInfoType

@synthesize marketType;
@synthesize deviceType;

+ (TransRetailInfoType *) transRetailInfoType {
    TransRetailInfoType *t = [[[TransRetailInfoType alloc] init] autorelease];
    return t;
}

- (id) init {
    self = [super init];
    if (self) {
        self.marketType = nil;
        self.deviceType = nil;
    }
    return self;
}

- (void) dealloc {
    self.marketType = nil;
    self.deviceType = nil;
    [super dealloc];
}

- (NSString *) description {
    NSString *output = [NSString stringWithFormat:@""
                        @"TransRetailInfoType.marketType = %@"
                        @"TransRetailInfoType.deviceType = %@",
                        self.marketType,
                        self.deviceType];
    return output;
}

- (NSString *)stringOfXMLRequest {
    NSString *s = [NSString stringWithFormat:@""
                       @"%@"    //marketType
                       @"%@",    //deviceType
                       [NSString stringWithXMLTag:@"marketType" andValue:self.marketType],
                       [NSString stringWithXMLTag:@"deviceType" andValue:self.deviceType]];
    return s;
}

@end
