//
//  CreditCardTrackType.h
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CreditCardTrackType : NSObject {
    NSString *_track1;
    NSString *_track2;
}

// User should only be setting track1 or track2
// We try to be smart here and remove delimiters and figure out which track is being set
// For best results, perform a check yourself, readers may provide an error in track data
@property (nonatomic, retain) NSString *track1;
@property (nonatomic, retain) NSString *track2;

/**
 * Creates an autoreleased  object
 * @return  an autoreleased  object.
 */
+ (CreditCardTrackType *) creditCardTrackType;

/**
 * NSString of the XML Request for this class
 * @return NSString of the XML Request structure for this class.
 */
- (NSString *) stringOfXMLRequest;

@end
