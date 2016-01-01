//
//  JSSplitContactTableViewCell.h
//  Fraction
//
//  Created by Norma Smalls-Mantey on 1/1/16.
//  Copyright © 2016 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSplitContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *contactField;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *cellOutilineView;


@end
