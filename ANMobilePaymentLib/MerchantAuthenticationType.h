//
//  MerchantAuthentication.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/3/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MerchantAuthenticationType : NSObject {

	NSString *name;
	NSString *transactionKey;
	NSString *sessionToken;
	NSString *password;
	NSString *mobileDeviceId;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *transactionKey;
@property (nonatomic, retain) NSString *sessionToken;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *mobileDeviceId;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (MerchantAuthenticationType *) merchantAuthentication;

/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *) stringOfXMLRequest;
@end
