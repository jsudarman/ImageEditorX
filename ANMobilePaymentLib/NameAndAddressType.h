//
//  NameAndAddressType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/22/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface NameAndAddressType : NSObject {
    NSString *firstName;
    NSString *lastName;
    NSString *company;
    NSString *address;
    NSString *city;
    NSString *state;
    NSString *zip;
    NSString *country;
}

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *country;

/**
 * Creates an autoreleased NameAndAddressType object;
 * @return NameAndAddressType an autoreleased NameAndAddressType object.
 */
+ (NameAndAddressType *) nameAndAddressType;
/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *) stringOfXMLRequest;
/**
 * LineItemType from parsing the XML response indexed by GDataXMLElement
 * @return NameAndAddressType autorelease instance of the parser generated object.
 */
+ (NameAndAddressType *) buildNameAndAddressType:(GDataXMLElement *)element;

@end
