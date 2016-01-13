//
//  JSConfirmationViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 1/12/16.
//  Copyright © 2016 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSConfirmationViewController.h"

@interface JSConfirmationViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UIPageViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (IBAction)menuButtonTapped:(id)sender;

@end

@implementation JSConfirmationViewController
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

- (IBAction)menuButtonTapped:(id)sender {
}
@end
