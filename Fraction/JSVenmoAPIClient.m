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

#import <Venmo-iOS-SDK/Venmo.h>


@implementation JSVenmoAPIClient

#pragma mark - Shared Venmo API Client

static JSVenmoAPIClient * venmoAPIClient;

+(JSVenmoAPIClient *)sharedInstance{
    
    if (nil == venmoAPIClient) {
        venmoAPIClient = [[JSVenmoAPIClient alloc]init];
    }
    return venmoAPIClient;
}


- (void)executeChargeWithPhoneNumber:(NSString *)phoneNumbers
                            andAmount:(NSString *)amount
                              andNote:(NSString *)note
                          andAudience:(NSString *)audience{
    
    [[Venmo sharedInstance] sendPaymentTo:phoneNumbers
                                   amount:amount.floatValue
                                     note:note
                        completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                            if (success) {
                                NSLog(@"Transaction succeeded!");
                            }
                            else {
                                NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                            }
                        }];
    

}

- (NSString *)returnPhoneNumberStringfromArray:(NSArray<CNLabeledValue<CNPhoneNumber*>*> *)contactArray{
    
    NSMutableString *iPhonePhoneNumber = @"";
    NSMutableString *mobilePhoneNumber = @"";
    NSMutableString *mainPhoneNumber   = @"";
    NSMutableString *otherPhoneNumber  = @"";
    
    //fill the assoated string if it matches the correct label
    
    for (CNLabeledValue *eachContact in contactArray) {
        
        if (eachContact.label == CNLabelPhoneNumberiPhone ) {
            NSMutableString *iPhonePhoneNumber = eachContact.value;
        }
        
        else if (eachContact.label == CNLabelPhoneNumberMobile ) {
            NSMutableString *mobilePhoneNumber = eachContact.value;
        }
        
        else if (eachContact.label == CNLabelPhoneNumberMain) {
            NSMutableString *mainPhoneNumber   = eachContact.value;
        }
        
        else {
            NSMutableString *otherPhoneNumber  = eachContact.value;
        }
        
    }
    
    //return whatever the iphone is first, then mobile, then main
    
    if (iPhonePhoneNumber.length > 4) {
        
        NSString *returnString = iPhonePhoneNumber;
        return returnString;
    }
    
    else if (mobilePhoneNumber.length > 4){
        
        NSString *returnString = mobilePhoneNumber;
        return returnString;
    }
    
    else if (mainPhoneNumber.length > 4){
        
        NSString *returnString = mainPhoneNumber;
        return returnString;
    }
    
    else{
        
        return otherPhoneNumber;
    }
        

}




#pragma mark - Get Authorization


#pragma mark - Send Money




@end

