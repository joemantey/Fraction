//
//  TransactionViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/5/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "TransactionViewController.h"


@interface TransactionViewController ()

@property (nonatomic) BOOL nameTextViewValid;
@property (nonatomic) BOOL amountTextViewValid;
@property (nonatomic) BOOL noteTextViewValid;

@property (weak, nonatomic) IBOutlet UISegmentedControl *payChargeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *nameTextView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privacySegementedControl;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;

- (IBAction)didSelectPayCharge:(id)sender;
- (IBAction)didSelectPrivacy:(id)sender;
- (IBAction)didTapBackButton:(id)sender;
- (IBAction)didTapSubmitButton:(id)sender;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearNavigationBar];
    [self roundCorners];
    [self setBackgroundColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearNavigationBar{
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(12, 0, 12, 24);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor      = [UIColor clearColor];
}


- (void)setBackgroundColor{
    
    UIColor *startColor         = [UIColor colorWithRed:0.091 green:0.598 blue:0.822 alpha:1.000];
    UIColor *endColor           = [UIColor colorWithRed:0.047 green:0.233 blue:0.364 alpha:1.000];
    CAGradientLayer*gradient    = [CAGradientLayer layer];
    gradient.frame              = self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    
}

- (void)roundCorners{
    
    self.nameTextView.layer.cornerRadius    = 8;
    self.nameTextView.layer.borderWidth     = 1;
    self.nameTextView.layer.borderColor     = [[UIColor whiteColor]CGColor];
    self.nameTextView.clipsToBounds         = YES;
    
    self.amountTextView.layer.cornerRadius  = 8;
    self.amountTextView.layer.borderWidth   = 1;
    self.amountTextView.layer.borderColor   = [[UIColor whiteColor]CGColor];
    self.amountTextView.clipsToBounds       = YES;
    
    self.noteTextView.layer.cornerRadius    = 8;
    self.noteTextView.layer.borderWidth     = 1;
    self.noteTextView.layer.borderColor     = [[UIColor whiteColor]CGColor];
    self.noteTextView.clipsToBounds         = YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didSelectPayCharge:(id)sender {
}
- (IBAction)didSelectPrivacy:(id)sender {
}

- (IBAction)didTapBackButton:(id)sender {
}
- (IBAction)didTapSubmitButton:(id)sender {
}
@end
