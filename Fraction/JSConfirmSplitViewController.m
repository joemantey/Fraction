//
//  JSConfirmSplitViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/27/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSConfirmSplitViewController.h"

#import "UIColor+Colors.h"

@interface JSConfirmSplitViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *privacySegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *notesTextField;
@property (weak, nonatomic) IBOutlet UIButton *completeTransactionButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

- (IBAction)didTapCompletTransactionButton:(id)sender;
- (IBAction)didTapBackButton:(id)sender;


@end

@implementation JSConfirmSplitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self clearNavigationBar];
    [self setBackgroundColor];
    [self setOutlines];
}



- (void)clearNavigationBar{
    
    self.navigationItem.leftBarButtonItem.imageInsets   = UIEdgeInsetsMake(12, 0, 12, 24);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor      = [UIColor clearColor];
}


- (void)setBackgroundColor{
    
    UIColor *startColor         = [UIColor greenLight];
    UIColor *endColor           = [UIColor greenLight];
    CAGradientLayer*gradient    = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)setOutlines{
    
    self.notesTextField.layer.cornerRadius              = 8;
    self.notesTextField.layer.borderWidth               = 1;
    self.notesTextField.layer.borderColor               = [[UIColor whiteColor]CGColor];
    self.notesTextField.clipsToBounds                   = YES;
    
    self.completeTransactionButton.layer.cornerRadius   = 8;
    self.completeTransactionButton.layer.borderWidth    = 1;
    self.completeTransactionButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.completeTransactionButton.clipsToBounds        = YES;
  
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapCompletTransactionButton:(id)sender {
}

- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
