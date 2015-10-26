//
//  JSSplitTableViewCell.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/23/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSVenPerson.h"

#import <UIKit/UIKit.h>

@interface JSSplitTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *sliderContainerView;
@property (weak, nonatomic) IBOutlet UIView *shareContainerView;
@property (weak, nonatomic) IBOutlet UIView *percentContainerView;
@property (weak, nonatomic) IBOutlet UITextField *contactTextView;
@property (weak, nonatomic) IBOutlet UITextField *shareTextView;
@property (weak, nonatomic) IBOutlet UITextField *percentTextView;
@property (weak, nonatomic) IBOutlet UISlider    *slider;

@property (strong, nonatomic)        JSVenPerson *cellVenPerson;

- (IBAction)sliderValueDidChange:(id)sender;


@end
