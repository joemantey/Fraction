//
//  JSSplitTransactionViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/21/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSSplitTransactionViewController.h"

@interface JSSplitTransactionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *postSplitAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (weak, nonatomic) IBOutlet UITextField *tipAmountField;
@property (weak, nonatomic) IBOutlet UISlider *taxSlider;
@property (weak, nonatomic) IBOutlet UIView *taxAmountField;
@property (weak, nonatomic) IBOutlet UIButton *completeTransactionButton;


- (IBAction)didTapAddContact:(id)sender;
- (IBAction)didFinishEditingContactTextField:(id)sender;
- (IBAction)didiEndEditingAmount:(id)sender;
- (IBAction)tipSliderValueChanged:(id)sender;
- (IBAction)taxSliderValueChanged:(id)sender;
- (IBAction)didTapCompletetTransaction:(id)sender;

@end

@implementation JSSplitTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tipSliderValueChanged:(id)sender {
}

- (IBAction)taxSliderValueChanged:(id)sender {
}

- (IBAction)didTapCompletetTransaction:(id)sender {
}

- (IBAction)didTapAddContact:(id)sender {
}

- (IBAction)didFinishEditingContactTextField:(id)sender {
}

- (IBAction)didiEndEditingAmount:(id)sender {
}
@end
