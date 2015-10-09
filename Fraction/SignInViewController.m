//
//  SignInViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/7/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "SignInViewController.h"
#import "JSMenuTableViewController.h"

#import <Venmo-iOS-SDK/Venmo.h>


@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
- (IBAction)didTapSignInButton:(id)sender;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)setBackgroundColor{
    
    UIColor *startColor         = [UIColor colorWithRed:0.108 green:0.649 blue:0.683 alpha:1.000];
    UIColor *endColor           = [UIColor colorWithRed:0.108 green:0.649 blue:0.683 alpha:1.000];
    CAGradientLayer*gradient    = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)presentLoggedInVC {
    [self performSegueWithIdentifier:@"presentLoggedInVC" sender:self];
}

- (IBAction)didTapSignInButton:(id)sender {
    
    [[Venmo sharedInstance] requestPermissions:@[VENPermissionMakePayments,
                                                 VENPermissionAccessProfile]
                         withCompletionHandler:^(BOOL success, NSError *error) {
                             if (success) {
                                 
                                 JSMenuTableViewController *menuVIewController = [[JSMenuTableViewController alloc]init];
                                 [self presentLoggedInVC];
                             }
                             else{
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry, we were unable to log you in. Please double-check your log-in information and try again"
                                                                                     message:nil
                                                                                    delegate:self
                                                                           cancelButtonTitle:nil
                                                                           otherButtonTitles:@"OK", nil];
                             }
                         }];

}
@end
