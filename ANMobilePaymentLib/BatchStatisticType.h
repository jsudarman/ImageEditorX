//
//  BatchStatisticType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/21/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface BatchStatisticType : NSObject {
    NSString *accountType;
    NSString *chargeAmount;
    NSString *refundAmount;
    NSString *refundCount;
    NSString *voidCount;
    NSString *declineCount;
    NSString *errorCount;
    NSString *returnedItemAmount;
    NSString *returnedItemCount;
    NSString *chargebackAmount;
    NSString *chargebackCount;
    NSString *correctionNoticeCount;
    NSString *chargeChargeBackAmount;
    NSString *chargeChargeBackCount;
    NSString *refundChargeBackAmount;
    NSString *refundChargeBackCount;
    NSString *chargeReturnedItemsAmount;
    NSString *chargeReturnedItemsCount;
    NSString *refundReturnedItemsAmount;
    NSString *refundReturnedItemsCount;
}

@property (nonatomic, retain) NSString *accountType;
@property (nonatomic, retain) NSString *chargeAmount;
@property (nonatomic, retain) NSString *refundAmount;
@property (nonatomic, retain) NSString *refundCount;
@property (nonatomic, retain) NSString *voidCount;
@property (nonatomic, retain) NSString *declineCount;
@property (nonatomic, retain) NSString *errorCount;
@property (nonatomic, retain) NSString *returnedItemAmount;
@property (nonatomic, retain) NSString *returnedItemCount;
@property (nonatomic, retain) NSString *chargebackAmount;
@property (nonatomic, retain) NSString *chargebackCount;
@property (nonatomic, retain) NSString *correctionNoticeCount;
@property (nonatomic, retain) NSString *chargeChargeBackAmount;
@property (nonatomic, retain) NSString *chargeChargeBackCount;
@property (nonatomic, retain) NSString *refundChargeBackAmount;
@property (nonatomic, retain) NSString *refundChargeBackCount;
@property (nonatomic, retain) NSString *chargeReturnedItemsAmount;
@property (nonatomic, retain) NSString *chargeReturnedItemsCount;
@property (nonatomic, retain) NSString *refundReturnedItemsAmount;
@property (nonatomic, retain) NSString *refundReturnedItemsCount;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (BatchStatisticType *) batchStaticistic;

/**
 * Class method that takes in GDataXMLElement and returns a fully parsed
 * BatchStatisticType.  If the method was not able to parse the response,
 * a nil object is returned.
 * @return The parsed BatchStatisticType from parsing the GDataXMLElement or nil if unable
 * to parse the data.
 */
+ (BatchStatisticType *)buildBatchStatistics:(GDataXMLElement *)element;

@end
