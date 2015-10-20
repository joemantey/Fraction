//
//  JSVenmoAPI.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/28/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSVenmoAPIClient.h"
#import "JSConstants.h"

#import "PayCharge.h"

@import Contacts;
@import ContactsUI;

@implementation JSVenmoAPIClient

#pragma mark - Shared Venmo API Client

static JSVenmoAPIClient * venmoAPIClient;

+(JSVenmoAPIClient *)sharedInstance{
    
    if (nil == venmoAPIClient) {
        venmoAPIClient = [[JSVenmoAPIClient alloc]init];
    }
    return venmoAPIClient;
}


- (void)buildPayChargeWithPhoneNumber:(NSString *)phoneNumbers
                            andAmount:(NSString *)amount
                              andNote:(NSString *)note
                          andAudience:(NSString *)audience
                      andChargeStatus:(BOOL)isCharge{
    
    
    
}

- (NSString *)returnPhoneNumberStringfromArray:(NSArray<CNLabeledValue<CNPhoneNumber*>*> *)contactArray{
    
    NSString *iPhonePhoneNumber = @"";
    NSString *mobilePhoneNumber = @"";
    NSString *mainPhoneNumber   = @"";
    NSString *otherPhoneNumber  = @"";
    
    //fill the assoated string if it matches the correct label
    
    for (CNLabeledValue *eachContact in contactArray) {
        
        if (eachContact.label == CNLabelPhoneNumberiPhone ) {
            NSString *iPhonePhoneNumber = eachContact.value;
        }
        
        else if (eachContact.label == CNLabelPhoneNumberMobile ) {
            NSString *mobilePhoneNumber = eachContact.value;
        }
        
        else if (eachContact.label == CNLabelPhoneNumberMain) {
            NSString *mainPhoneNumber   = eachContact.value;
        }
        
        else {
            NSString *otherPhoneNumber  = eachContact.value;
        }
        
    }
    
    //return whatever the iphone is first, then mobile, then main
    
    if (iPhonePhoneNumber.length > 4) {
        return iPhonePhoneNumber;
    }
    
    else if (mobilePhoneNumber.length > 4){
        return mobilePhoneNumber;
    }
    
    else if (mainPhoneNumber.length > 4){
        return mainPhoneNumber;
    }
    
    else{
        return otherPhoneNumber;
    }
        

}

#pragma mark - Get Authorization


#pragma mark - Send Money




@end

