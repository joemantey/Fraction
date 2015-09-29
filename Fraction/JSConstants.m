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
NSString *const VENMO_API_APP_SECRET                = @"MknhcYXsA9pJJdjYB6Y5RQHmEdCQpbww";

NSString *const VENMO_POST_PAYMENT_URL              = @"https://api.venmo.com/v1/payments";
NSString *const VENMO_API_REDIRECT_URL              = @"https://api.venmo.com/v1/oauth/authorize?client_id=2960&scope=make_payments%20access_payment_history%20access_feed%20access_profile%20access_emaiL%20access_phone%20access_balance%20access_friends&response_type=token&redirect_uri=YosimiteFraction://";

#pragma mark Venmo API Sandbox
#warning SWITCH FROM SANDBOX TO ACTUAL LINKS BEFORE RELEASE
NSString *const VENMO_SANDBOX_POST_PAYMENT_URL      = @"https://sandbox-api.venmo.com/v1/payments";
NSString *const VENMO_SANDBOX_USER_ID               = @"145434160922624933";
NSString *const VENMO_SANDBOX_EMAIL                 = @"venmo@venmo.com";
NSString *const VENMO_SANDBOX_PHONE                 = @"15555555555";
NSString *const VENMO_SANDBOX_NOTE                  = @"TEST NOTE";
NSString *const VENMO_SANDBOX_PAYMENT_SETTLED       = @"0.10";
NSString *const VENMO_SANDBOX_PAYMENT_FAILURE       = @"0.20";
NSString *const VENMO_SANDBOX_PAYMENT_PENDING       = @"0.30";
NSString *const VENMO_SANDBOX_CHARGE_SETTLED        = @"-0.10";
NSString *const VENMO_SANDBOX_CHARGE_PENDING        = @"-0.20";
@end
