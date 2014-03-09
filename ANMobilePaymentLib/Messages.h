//
//  Messages.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 1/17/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@class AuthNetMessage;

@interface Messages : NSObject {
	
	NSString *resultCode;
	NSMutableArray *messageArray;

}

@property (nonatomic, retain) NSString *resultCode;
@property (nonatomic, retain) NSMutableArray *messageArray;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (Messages *) messages;
+ (Messages *) buildMessages:(GDataXMLElement *)element;

@end
