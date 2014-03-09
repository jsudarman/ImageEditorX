//
//  GetBatchStatisticsResponse.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/25/11.
//  Copyright 2011 none. All rights reserved.
//

#import "GetBatchStatisticsResponse.h"
#import "NSString+dataFromFilename.h"

@implementation GetBatchStatisticsResponse

@synthesize batch;

+ (GetBatchStatisticsResponse *) getBatchStatisticsResponse {
    GetBatchStatisticsResponse *g = [[[GetBatchStatisticsResponse alloc] init] autorelease];
    return g;
}

- (id) init {
    self = [super init];
    if (self) {
        self.batch = [BatchDetailsType batchDetails];
    }
    return self;
}

- (void) dealloc {
    self.batch = nil;
    [super dealloc];
}


- (NSString *) description {
    NSString *output = [NSString stringWithFormat:@""
                        @"GetBatchStatisticsResponse.anetApiResponse = %@"
                        @"GetBatchStatisticsResponse.batch = %@",
                        self.anetApiResponse,
                        self.batch];
    return  output;
}

+ (GetBatchStatisticsResponse *)parseGetBatchStatisticsResponse:(NSData *)xmlData {
    NSError *error;
	
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
	
	NSLog(@"Error = %@", error);
	
    if (doc == nil) { return nil; }
	
	GetBatchStatisticsResponse *t = [GetBatchStatisticsResponse getBatchStatisticsResponse];
	
	t.anetApiResponse = [ANetApiResponse buildANetApiResponse:doc.rootElement];
    
    NSArray *currArray = [doc.rootElement elementsForName:@"batch"];
  	GDataXMLElement *currNode = (GDataXMLElement *) [currArray objectAtIndex:0];
    t.batch = [BatchDetailsType buildBatchDetails:currNode];
    
	NSLog(@"GetBatchStatisticsResponse: %@", t);
	
    [doc release];
    return t;
}

// For unit testing only.
+ (GetBatchStatisticsResponse *)loadGetBatchStatisticsResponseFromFilename:(NSString *)filename {
    
    NSString *filePath = [NSString dataFromFilename:filename];

    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
	GetBatchStatisticsResponse *t = [self parseGetBatchStatisticsResponse:xmlData];
    [xmlData release];
    return t;
}

@end
