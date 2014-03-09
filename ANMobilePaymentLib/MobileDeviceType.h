//
//  MobileDevice.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/4/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MobileDeviceType : NSObject {
	NSString *mobileDeviceId;
	NSString *mobileDescription;
	NSString *phoneNumber;
}

@property (nonatomic, retain) NSString *mobileDeviceId;
@property (nonatomic, retain) NSString *mobileDescription;
@property (nonatomic, retain) NSString *phoneNumber;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (MobileDeviceType *) mobileDevice;

/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *) stringOfXMLRequest;
@end
