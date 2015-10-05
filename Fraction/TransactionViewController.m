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

- (IBAction)didSelectPayCharge:(id)sender;
- (IBAction)didSelectPrivacy:(id)sender;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearNavigationBar];

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
@end
