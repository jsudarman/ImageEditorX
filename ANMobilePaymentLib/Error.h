//
//  Error.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 1/19/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Error : NSObject {

	NSString *errorCode;
	NSString *errorText;
}

@property (nonatomic, retain) NSString *errorCode;
@property (nonatomic, retain) NSString *errorText;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (Error *) error;

@end
