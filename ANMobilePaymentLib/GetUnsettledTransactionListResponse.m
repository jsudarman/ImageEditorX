//
//  GetUnsettledTransactionListResponse.m
//  ANMobilePaymentLib
//
//  Created by Authorize.Net on 3/24/11.
//  Copyright 2011 none. All rights reserved.
//

#import "GetUnsettledTransactionListResponse.h"
#import "TransactionSummaryType.h"
#import "NSString+dataFromFilename.h"

@implementation GetUnsettledTransactionListResponse

@synthesize transactions;


+ (GetUnsettledTransactionListResponse *) getUnsettledTransactionListResponse {
    GetUnsettledTransactionListResponse *g = [[[GetUnsettledTransactionListResponse alloc] init] autorelease];
    return g;
}

- (id) init {
    self = [super init];
    if (self) {
        self.transactions = [NSMutableArray array];
    }
    return self;
}

- (void) dealloc {
    self.transactions = nil;
    [super dealloc];
}

- (NSString *) description {
    NSString *output = [NSString stringWithFormat:@""
                        @"GetUnsettledTransactionListResponse.anetApiResponse = %@"
                        @"GetUnsettledTransactionListResponse.transactions = %@",
                        self.anetApiResponse,
                        self.transactions];
    return output;
}


+ (GetUnsettledTransactionListResponse *)parseGetUnsettledTransactionListResponse:(NSData *)xmlData {
    NSError *error;
	
    GDataXMLDocument *doc = [[[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error] autorelease];
	
	NSLog(@"Error = %@", error);
	
    if (doc == nil) { return nil; }
	
	GetUnsettledTransactionListResponse *g = [GetUnsettledTransactionListResponse getUnsettledTransactionListResponse];
	
	g.anetApiResponse = [ANetApiResponse buildANetApiResponse:doc.rootElement];
    
    
    NSArray *currArray = [doc.rootElement elementsForName:@"transactions"];
	GDataXMLElement *currNode = (GDataXMLElement *) [currArray objectAtIndex:0];
	
	
	currArray = [currNode elementsForName:@"transaction"];
	for (GDataXMLElement *node in currArray) {
        TransactionSummaryType *ts = [TransactionSummaryType buildTransactionSummaryType:node];
		[g.transactions addObject:ts];
	}
    
    return g;
}


// For unit testing.
+ (GetUnsettledTransactionListResponse *)loadGetUnsettledTransactionListResponseFromFilename:(NSString *)filename {
    NSString *filePath = [NSString dataFromFilename:filename];
	// TODO: Change this to process from HTTP response data
	// after initial testing.
    NSData *xmlData = [[[NSMutableData alloc] initWithContentsOfFile:filePath] autorelease];
	GetUnsettledTransactionListResponse *g = [self parseGetUnsettledTransactionListResponse:xmlData];
    return g;
}

@end
