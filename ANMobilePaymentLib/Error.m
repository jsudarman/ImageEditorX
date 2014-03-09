//
//  Error.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 1/19/11.
//  Copyright 2011 none. All rights reserved.
//

#import "Error.h"


@implementation Error
@synthesize errorCode;
@synthesize errorText;

+ (Error *) error {
	Error *e = [[[Error alloc] init] autorelease];
	return e;
}

- (id) init {
    self = [super init];
	if (self) {
		self.errorCode = nil;
		self.errorText = nil;
	}
	return self;
}

- (void) dealloc {
	
	self.errorCode = nil;
	self.errorText = nil;
	[super dealloc];
}

- (NSString *) description {
	NSString * s = [NSString stringWithFormat:@""
					"Error.errorCode = %@\n"
					"Error.errorText = %@\n",
					self.errorCode,
					self.errorText];
	
	return s;
}

@end
