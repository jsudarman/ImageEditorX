//
//  CreditCardTrackType.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/23/11.
//  Copyright 2011 none. All rights reserved.
//

#import "CreditCardTrackType.h"
#import "NSString+stringWithXMLTag.h"


@implementation CreditCardTrackType

@synthesize track1=_track1;
@synthesize track2=_track2;

+ (CreditCardTrackType *) creditCardTrackType {
    CreditCardTrackType *c = [[[CreditCardTrackType alloc] init] autorelease];
    return c;
}

- (id) init {
    self = [super init];
    if (self) {
        self.track1 = nil;
        self.track2 = nil;
    }
    return self;
}

- (void) dealloc {
    self.track1 = nil;
    self.track2 = nil;
    [super dealloc];
}

- (void)setTrack1:(NSString *)track1 {
    if (_track1 != nil) {
        [_track1 release];
    }
    
    _track1 = [track1 stringByReplacingOccurrencesOfString:@"%" withString:@""];
    _track1 = [[_track1 stringByReplacingOccurrencesOfString:@"?" withString:@""] retain];
}

- (void)setTrack2:(NSString *)track2 {
    if (_track2 != nil) {
        [_track2 release];
    }
    
    _track2 = [track2 stringByReplacingOccurrencesOfString:@";" withString:@""];
    _track2 = [[_track2 stringByReplacingOccurrencesOfString:@"?" withString:@""] retain];
}

- (NSString *) description {
    NSString *output = [NSString stringWithFormat:@""
                        @"CreditCardTrackType.track1 = %@"
                        @"CreditCardTrackType.track2 = %@",
                        self.track1,
                        self.track2];
    return output;
}

- (NSString *) stringOfXMLRequest {
    NSString *s = @""; 
        
    if (self.track1 != nil && ![self.track1 isEqualToString:@""]) {
        s = [NSString stringWithFormat:@""
                   @"<trackData>"
                        @"%@"       //track1
                   @"</trackData>",
                   [NSString stringWithXMLTag:@"track1" andValue:self.track1]];
    } else {
        s = [NSString stringWithFormat:@""
                    @"<trackData>"
                        @"%@"       //track2
                    @"</trackData>",
                    [NSString stringWithXMLTag:@"track2" andValue:self.track2]];
    }
    
    
    return s;
}
@end
