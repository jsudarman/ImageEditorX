//
//  TransRetailInfoType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MARKET_TYPE_RETAIL;

extern NSString * const DEVICE_TYPE_UNKNOWN;
extern NSString * const DEVICE_TYPE_UNATTENDED;
extern NSString * const DEVICE_TYPE_SELF_SERVICE_TERMINAL;
extern NSString * const DEVICE_TYPE_ELECTRONIC_CASH_REGISTER;
extern NSString * const DEVICE_TYPE_PERSONAL_COMPUTER_BASED_TERMINAL;
extern NSString * const DEVICE_TYPE_AIRPAY;
extern NSString * const DEVICE_TYPE_WIRELESS_POS;
extern NSString * const DEVICE_TYPE_WEBSITE;
extern NSString * const DEVICE_TYPE_DIAL_TERMINAL;
extern NSString * const DEVICE_TYPE_VIRTUAL_TERMINAL;

@interface TransRetailInfoType : NSObject {
    NSString *marketType;
    NSString *deviceType;
}

@property (nonatomic, retain) NSString *marketType;
@property (nonatomic, retain) NSString *deviceType;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (TransRetailInfoType *) transRetailInfoType;

/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *)stringOfXMLRequest;
@end
