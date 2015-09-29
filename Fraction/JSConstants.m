//
//  JSConstants.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/28/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSConstants.h"

@implementation JSConstants



#pragma mark Venmo API
NSString *const VENMO_API_BASE_URL                  = @"https://api.venmo.com/v1";
NSString *const VENMO_API_APP_ID                    = @"2960";
NSString *const VENMO_API_REDIRECT_URL              = @"https://api.venmo.com/v1/oauth/authorize?client_id=2960&scope=make_payments%20access_payment_history%20access_feed%20access_profile%20access_emaiL%20access_phone%20access_balance%20access_friends&response_type=token&redirect_uri=YosimiteFraction://";


@end
