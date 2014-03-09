//
//  LogoutResponse.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/7/11.
//  Copyright 2011 none. All rights reserved.
//

#import "LogoutResponse.h"
#import "NSString+dataFromFilename.h"

@implementation LogoutResponse

+ (LogoutResponse *) logoutResponse {
	LogoutResponse *m = [[[LogoutResponse alloc] init] autorelease];
	return m;
}

- (id) init {
    self = [super init];
	if (self) {
	}
	return self;
}

- (void) dealloc {
	[super dealloc];
}

- (NSString *) description {
	
	NSString *output = [NSString stringWithFormat:@""
						"LogoutResponse.anetApiResponse = %@\n",
						self.anetApiResponse];
	return output;
}

+ (LogoutResponse *)parseLogoutResponse:(NSData *)xmlData {
	NSError *error;
	
    GDataXMLDocument *doc = [[[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 
															 error:&error] autorelease];
	
	NSLog(@"Error = %@", error);
	
    if (doc == nil) { return nil; }
	
	LogoutResponse *m = [LogoutResponse logoutResponse];
	
	m.anetApiResponse = [ANetApiResponse buildANetApiResponse:doc.rootElement];
	
	NSLog(@"LogoutResponse: %@", m);
	
    return m;
}

// For unit testing.
+ (LogoutResponse *)loadLogoutResponseFromFilename:(NSString *)filename {
    NSString *filePath = [NSString dataFromFilename:filename];
	
    NSData *xmlData = [[[NSMutableData alloc] initWithContentsOfFile:filePath] autorelease];
    LogoutResponse *m = [self parseLogoutResponse:xmlData];
	
	return m;
}
@end
