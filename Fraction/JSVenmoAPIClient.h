//
//  JSVenmoAPI.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/28/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Contacts;
@import ContactsUI;

@interface JSVenmoAPIClient : NSObject

@property (nonatomic) BOOL permissionsGranted;

+ (JSVenmoAPIClient *)sharedInstance;

- (void)executeChargeWithPhoneNumber:(NSString *)phoneNumbers
                            andAmount:(NSString *)amount
                              andNote:(NSString *)note
                          andAudience:(NSString *)audience;

- (NSString *)returnPhoneNumberStringfromArray:(NSArray<CNLabeledValue<CNPhoneNumber*>*> *)contactArray;

@end
