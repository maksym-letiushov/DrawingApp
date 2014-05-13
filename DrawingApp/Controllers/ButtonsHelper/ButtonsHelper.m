//
//  ButtonsHelper.m
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ButtonsHelper.h"

@implementation ButtonsHelper

+ (UIBarButtonItem *)twoStateBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    NSAttributedString *normalAttrString = [AttributedStringMaster normalBarButtonItemWithString:title];
    NSAttributedString *selectedAttrString = [AttributedStringMaster selectedBarButtonItemWithString:title];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setAttributedTitle:normalAttrString forState:(UIControlStateNormal)];
    [button setAttributedTitle:selectedAttrString forState:(UIControlStateSelected)];
    [button setAttributedTitle:selectedAttrString forState:(UIControlStateHighlighted)];
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    CGRect frame = CGRectZero;
    frame.size = selectedAttrString.size;
    button.frame = frame;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

@end
