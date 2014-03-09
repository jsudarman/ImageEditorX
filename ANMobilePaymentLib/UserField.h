//
//  UserField.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 1/12/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserField : NSObject {
	NSString *name;
	NSString *value;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (UserField *) userField;
/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *) stringOfXMLRequest;

@end
