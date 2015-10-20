//
//  JSVenmoAPI.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/28/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSVenmoAPIClient : NSObject

+(JSVenmoAPIClient *)sharedInstance;

- (void)buildPayChargeWithPhoneNumber:(NSString *)phoneNumbers
                            andAmount:(NSString *)amount
                              andNote:(NSString *)note
                          andAudience:(NSString *)audience
                      andChargeStatus:(BOOL)isCharge;

@end
