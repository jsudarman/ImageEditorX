//
//  MerchantContactType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/3/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface MerchantContactType : NSObject {
	NSString *merchantName;
	NSString *merchantAddress;
	NSString *merchantCity;
	NSString *merchantState;
	NSString *merchantZip;
	NSString *merchantPhone;
}

@property (nonatomic, retain) NSString *merchantName;
@property (nonatomic, retain) NSString *merchantAddress;
@property (nonatomic, retain) NSString *merchantCity;
@property (nonatomic, retain) NSString *merchantState;
@property (nonatomic, retain) NSString *merchantZip;
@property (nonatomic, retain) NSString *merchantPhone;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (MerchantContactType *) merchantContact;

/**
 * MerchantContactType from parsing the XML response indexed by GDataXMLElement
 * @return MerchantContactType autorelease instance of the parser generated object.
 */
+ (MerchantContactType *) buildMerchantContact:(GDataXMLElement *)element;
@end
