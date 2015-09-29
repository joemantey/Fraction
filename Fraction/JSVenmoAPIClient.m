//
//  JSVenmoAPI.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/28/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSVenmoAPIClient.h"
#import "JSConstants.h"

@implementation JSVenmoAPIClient

#pragma mark - Shared Venmo API Client

static JSVenmoAPIClient * venmoAPIClient;

+(JSVenmoAPIClient *)sharedInstance{
    
    if (nil == venmoAPIClient) {
        venmoAPIClient = [[JSVenmoAPIClient alloc]init];
    }
    return venmoAPIClient;
}

#pragma mark - Get Authorization

+(void)getVenmoAuthorizationCodeForUser:()

#pragma mark - Send Money

+(void)sendMoneyWithID:(NSString*)IDString andNote:(NSString*)note andAmount:(NSString*)amount andAudience:(NSString *)audience Completion:(void (^)(NSDictionary *))completionBlock{
    
    NSString *sqootURL = VENMO_SANDBOX_POST_PAYMENT_URL;
    NSDictionary *parameterDictionary = @{@"api_key":VENMO_API_APP_ID};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:sqootURL parameters:parameterDictionary success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dealQueryResponseDictionary= ((NSDictionary *)responseObject)[@"deal"];
         completionBlock(dealQueryResponseDictionary);
     }
     
         failure:^(NSURLSessionDataTask *task, NSError *error){
             NSLog(@"Failed to search: %@", error.localizedDescription);
         }];
    
}


@end
