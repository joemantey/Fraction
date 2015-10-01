//
//  MenuTableViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/1/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSMenuTableViewController.h"

@interface JSMenuTableViewController ()

@end

@implementation JSMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setBackgroundColor{
    
    UIColor *startColor = [UIColor colorWithRed:0.047 green:0.233 blue:0.364 alpha:1.000];
    UIColor *endColor   = [UIColor colorWithRed:0.022 green:0.110 blue:0.172 alpha:1.000];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    //    gradient.startPoint = CGPointMake(0, 0);
    //    gradient.endPoint = CGPointMake(self.view.frame.size.height, 0);
    gradient.colors = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    
    [self.view.layer insertSublayer:gradient atIndex:0];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row== 0)
        return self.tableView.frame.size.height / 4;
    else
        return self.tableView.frame.size.height * 3/ 36;
}


@end
