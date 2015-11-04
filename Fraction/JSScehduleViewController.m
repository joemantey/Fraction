//
//  JSScehduleViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 11/4/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSScehduleViewController.h"
#import "JSCoreData.h"

@interface JSScehduleViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *completeTransactionButton;

@property (strong, nonatomic) JSCoreData        *dataStore;

@end

@implementation JSScehduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataStore          = [JSCoreData sharedDataStore];
    [self clearNavigationBar];
    [self setBackgroundColor];
    [self setUpViewsAndButtons];

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
    
    UIColor *startColor         = [UIColor colorWithRed:0.000 green:0.806 blue:0.827 alpha:1.000];
    UIColor *endColor           = [UIColor colorWithRed:0.000 green:0.806 blue:0.827 alpha:1.000];
    CAGradientLayer*gradient    = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void)setUpViewsAndButtons{
    
    self.datePicker.layer.cornerRadius        = 8;
    self.datePicker.layer.borderWidth         = 1;
    self.datePicker.layer.borderColor         = [[UIColor whiteColor]CGColor];
    self.datePicker.clipsToBounds             = YES;
    self.datePicker.minimumDate               = [NSDate date];
    
    self.completeTransactionButton.layer.cornerRadius   = 8;
    self.completeTransactionButton.layer.borderWidth    = 1;
    self.completeTransactionButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.completeTransactionButton.clipsToBounds        = YES;
    [self.completeTransactionButton setTitle:@"Please complete all fields" forState:UIControlStateNormal];
    self.completeTransactionButton.userInteractionEnabled= NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
