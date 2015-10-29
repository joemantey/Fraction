//
//  JSHomeViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/30/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSHomeViewController.h"
#import "JSCoreData.h"
#import "UIColor+Colors.h"

#import <QuartzCore/QuartzCore.h>

#include <stdlib.h>

#import <Venmo-iOS-SDK/Venmo.h>

@interface JSHomeViewController ()


@property (strong, nonatomic) JSCoreData *dataStore;

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendFundsButton;
@property (weak, nonatomic) IBOutlet UIButton *splitBillButton;
@property (weak, nonatomic) IBOutlet UIButton *scheduleTransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *startATabButton;

- (IBAction)didTapMenuButton:(id)sender;

@end

@implementation JSHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self clearNavigationBar];
    [self setBackgroundColor];
    [self setOutlines];
    [self setWelcomeMessage];
    [self setUpDataStore];
    [self askForPermissions];
    
    self.navigationItem.leftBarButtonItem.action = @selector(presentLeftMenuViewController:);
}

- (void)setUpDataStore{
    
    self.dataStore = [JSCoreData sharedDataStore];
}

#warning remember to turmn back on asking for permissions

- (void)askForPermissions{
    
//    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments,
//                                                 VENPermissionAccessProfile,
//                                                 VENPermissionAccessPhone,
//                                                 VENPermissionAccessBalance]
//     
//                         withCompletionHandler:^(BOOL success, NSError *error) {
//                             if (success) {
//                                 
//                                 self.dataStore.didGainPermissions = YES;
//                             }
//                             else {
//                                 
//                                 self.dataStore.didGainPermissions = NO;
//                             }
//                         }
//     ];
}

- (void)setWelcomeMessage{
    
    NSArray *welcomeMessageArray = @[@"Hi! What would you like to do?",
                                     @"Welcome back!",
                                     @"Hey there. How can I help?"];
    
    int random = arc4random_uniform(2);
    
    self.welcomeLabel.text = [welcomeMessageArray objectAtIndex:random];
}


- (void)setBackgroundColor{
    
    UIColor *startColor = [UIColor colorWithRed:0.091 green:0.598 blue:0.822 alpha:1.000];
    UIColor *endColor = [UIColor colorWithRed:0.091 green:0.598 blue:0.822 alpha:1.000];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(self.view.frame.size.height, 0);
    gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)clearNavigationBar{
    
    
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(12, 0, 12, 24);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor      = [UIColor clearColor];
}

- (void)setOutlines{
    
    self.sendFundsButton.layer.cornerRadius            = 8;
    self.sendFundsButton.layer.borderWidth             = 1;
    self.sendFundsButton.layer.borderColor             = [[UIColor whiteColor]CGColor];
    self.sendFundsButton.clipsToBounds                 = YES;
    
    self.splitBillButton.layer.cornerRadius            = 8;
    self.splitBillButton.layer.borderWidth             = 1;
    self.splitBillButton.layer.borderColor             = [[UIColor whiteColor]CGColor];
    self.splitBillButton.clipsToBounds                 = YES;
    
    self.scheduleTransactionButton.layer.cornerRadius  = 8;
    self.scheduleTransactionButton.layer.borderWidth   = 1;
    self.scheduleTransactionButton.layer.borderColor   = [[UIColor whiteColor]CGColor];
    self.scheduleTransactionButton.clipsToBounds       = YES;
    
    self.startATabButton.layer.cornerRadius            = 8;
    self.startATabButton.layer.borderWidth             = 1;
    self.startATabButton.layer.borderColor             = [[UIColor whiteColor]CGColor];
    self.startATabButton.clipsToBounds                 = YES;
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapMenuButton:(id)sender {
    
}
@end
