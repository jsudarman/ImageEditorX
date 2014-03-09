//
//  MobileDevice.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/4/11.
//  Copyright 2011 none. All rights reserved.
//

#import "MobileDeviceType.h"
#import "NSString+stringWithXMLTag.h"

@implementation MobileDeviceType

@synthesize mobileDeviceId;
@synthesize mobileDescription;
@synthesize phoneNumber;

+ (MobileDeviceType *) mobileDevice {
	MobileDeviceType *m = [[[MobileDeviceType alloc] init] autorelease];
	return m;
}

- (id) init {
    self = [super init];
	if (self) {
		self.mobileDeviceId = nil;
		self.mobileDescription = nil;
		self.phoneNumber = nil;
	}
	return self;
}

- (void) dealloc {
	self.mobileDeviceId = nil;
	self.mobileDescription = nil;
	self.phoneNumber = nil;
	[super dealloc];
}



- (NSString *) description {
	
	NSString *output = [NSString stringWithFormat:@""
						"MobileDevice.mobileDeviceId = %@\n"
						"MobileDevice.mobileDescription = %@\n"
						"MobileDevice.phoneNumber = %@",
						self.mobileDeviceId,
						self.mobileDescription,
						self.phoneNumber];
	return output;
}


- (NSString *) stringOfXMLRequest 
{
	NSString *s = [NSString stringWithFormat:@""
				   @"<mobileDevice>"
						@"%@"       //mobileDeviceId
						@"%@"		//description (optional)
						@"%@"		//phoneNumber (optional)
				   @"</mobileDevice>",
				   [NSString stringWithXMLTag:@"mobileDeviceId" andValue:self.mobileDeviceId],
				   (self.mobileDescription ? [NSString stringWithXMLTag:@"description" andValue:self.mobileDescription] : @""),
				   (self.phoneNumber ? [NSString stringWithXMLTag:@"phoneNumber" andValue:self.phoneNumber] : @"")];
	
	return s;
}
@end
