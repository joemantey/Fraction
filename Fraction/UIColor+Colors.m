//
//  UIColor+Colors.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/27/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "UIColor+Colors.h"

@implementation UIColor (Colors)

#pragma mark Deep Blue
+ (UIColor *)deepBlueLight{
    return [UIColor colorWithRed:0.047 green:0.233 blue:0.364 alpha:1.000];
}

+ (UIColor * )deepBlueDark{
    return [UIColor colorWithRed:0.022 green:0.110 blue:0.172 alpha:1.000];
}


#pragma mark Blue
+ (UIColor *)blueLight{
    return [UIColor colorWithRed:0.091 green:0.598 blue:0.822 alpha:1.000];
}

+ (UIColor * )blueDark{
    return [UIColor colorWithRed:0.047 green:0.233 blue:0.364 alpha:1.000];
}


#pragma mark Green
+ (UIColor *)greenLight{
    return [UIColor colorWithRed:0.062 green:0.784 blue:0.655 alpha:1.000];
}

+ (UIColor *)greenDark{
    return [UIColor colorWithRed:0.102 green:0.784 blue:0.525 alpha:1.000];
}

+ (UIColor *)greenClear{
    return [UIColor colorWithRed:0.062 green:0.784 blue:0.655 alpha:0.01];
}


#pragma mark Seafoam
+ (UIColor *)seafoamLight{
    return [UIColor colorWithRed:0.000 green:0.806 blue:0.827 alpha:1.000];
}

+ (UIColor *)seafoamDark{
    return [UIColor colorWithRed:0.000 green:0.188 blue:0.193 alpha:1.000];
}

@end
