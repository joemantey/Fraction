//
//  JSSplitContactTableViewCell.m
//  Fraction
//
//  Created by Norma Smalls-Mantey on 1/1/16.
//  Copyright © 2016 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSSplitContactTableViewCell.h"

@implementation JSSplitContactTableViewCell

- (void)awakeFromNib {

    [self configureBorders];
}

-(void)configureBorders{
    
    self.cellOutilineView.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.cellOutilineView.layer.borderWidth = 1;
    self.cellOutilineView.clipsToBounds     = YES;
}


@end
