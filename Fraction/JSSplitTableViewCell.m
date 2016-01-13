//
//  JSSplitTableViewCell.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/23/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSSplitTableViewCell.h"
#import "JSConstants.h"



@implementation JSSplitTableViewCell


- (void)awakeFromNib {
    
    [self setUpBorders];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpBorders{
    
    self.cellBackgroundView.layer.borderColor   = [[UIColor colorWithWhite:1 alpha:1]CGColor];
    self.cellBackgroundView.layer.borderWidth   = BORDER_WIDTH;
    self.cellBackgroundView.layer.cornerRadius  = CORNER_RADIUS;
    self.cellBackgroundView.clipsToBounds       = YES;
    self.cellBackgroundView.backgroundColor     = [UIColor colorWithWhite:1 alpha:0.15];
    
    self.sliderContainerView.layer.borderColor  = [[UIColor clearColor]CGColor];
    self.sliderContainerView.layer.borderWidth  = BORDER_WIDTH;
    self.sliderContainerView.clipsToBounds      = YES;
    
    self.shareContainerView.layer.borderColor   = [[UIColor clearColor]CGColor];
    self.shareContainerView.layer.borderWidth   = BORDER_WIDTH;
    self.shareContainerView.clipsToBounds       = YES;
   
}

- (IBAction)sliderValueDidChange:(id)sender {
}
@end
