//
//  Messages.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 1/17/11.
//  Copyright 2011 none. All rights reserved.
//

#import "Messages.h"

#import "AuthNetMessage.h"
#import "NSString+stringValueOfXMLElement.h"

@implementation Messages

@synthesize resultCode;
@synthesize messageArray;

+ (Messages *) messages {
	Messages *m = [[[Messages alloc] init] autorelease];
	return m;
}

- (id) init {
    self = [super init];
	if (self) {
		self.resultCode = nil;
		self.messageArray = [NSMutableArray array];
	}
	return self;
}


- (void) dealloc {
	self.resultCode = nil;
	self.messageArray = nil;
	[super dealloc];
}


- (NSString *) description {
	
	NSString *output = [NSString stringWithFormat:@""
						"Messages.resultCode = %@\n"
						"Messages.message = %@\n",
						self.resultCode,
						self.messageArray];
	return output;
}

+ (Messages *) buildMessages:(GDataXMLElement *)element {
	GDataXMLElement *currNode;
	Messages *m = [Messages messages];
	
	NSArray *currArray = [element elementsForName:@"messages"];
	currNode = (GDataXMLElement *) [currArray objectAtIndex:0];
	
	m.resultCode = [NSString stringValueOfXMLElement:currNode withName:@"resultCode"];
	
	
	currArray = [currNode elementsForName:@"message"];
	for (GDataXMLElement *node in currArray) {
		AuthNetMessage *message = [AuthNetMessage buildMessage:node];
		[m.messageArray addObject:message];
	}
	// debugging 
	NSLog(@"Messages: \n%@", m);
	
	return m;
}

@end
