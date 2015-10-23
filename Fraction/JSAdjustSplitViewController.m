//
//  JSAdjustSplitViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/23/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSAdjustSplitViewController.h"
#import "JSSplitTableViewCell.h"

#import "JSCoreData.h"

@import Contacts;

@interface JSAdjustSplitViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) JSCoreData        *dataStore;

@property (weak, nonatomic) IBOutlet UIView *backgroundContainer;
@property (weak, nonatomic) IBOutlet UIView *amountRemainingContainer;
@property (weak, nonatomic) IBOutlet UITextField *amountRemainingTextView;
@property (weak, nonatomic) IBOutlet UITextField *perAmountRemainingTextView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapBackButton:(id)sender;


@end

@implementation JSAdjustSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCoreData];
    [self clearNavigationBar];
    [self setBackgroundColor];
    [self setOutlines];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCoreData{
    
    self.dataStore = [JSCoreData sharedDataStore];
    
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
    CAGradientLayer *gradient   = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}


- (void)setOutlines{
    
    self.backgroundContainer.layer.cornerRadius         = 8;
    self.backgroundContainer.layer.borderWidth          = 1;
    self.backgroundContainer.layer.borderColor          = [[UIColor whiteColor]CGColor];
    self.backgroundContainer.clipsToBounds              = YES;
    
    self.amountRemainingContainer.layer.cornerRadius    = 8;
    self.amountRemainingContainer.layer.borderWidth     = 1;
    self.amountRemainingContainer.layer.borderColor     = [[UIColor whiteColor]CGColor];
    self.amountRemainingContainer.clipsToBounds         = YES;
}



#pragma mark - Tableview Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.dataStore saveContext];
    }];
    
}
@end
