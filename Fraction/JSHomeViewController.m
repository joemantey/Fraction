//
//  JSHomeViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/30/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSHomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface JSHomeViewController ()

@end

@implementation JSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearNavigationBar];
    [self setBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setBackgroundColor{
    
    UIColor *startColor = [UIColor colorWithRed:0.084 green:0.552 blue:0.760 alpha:1.000];
    UIColor *endColor = [UIColor colorWithRed:0.047 green:0.233 blue:0.364 alpha:1.000];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
