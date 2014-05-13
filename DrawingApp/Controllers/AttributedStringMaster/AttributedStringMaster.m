//
//  AttributedStringMaster.m
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "AttributedStringMaster.h"

@implementation AttributedStringMaster

+ (NSAttributedString *)normalBarButtonItemWithString:(NSString *)string
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string
                                                                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                                                                                NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    
    
    return attrString;
}

+ (NSAttributedString *)selectedBarButtonItemWithString:(NSString *)string
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string
                                                                            attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                                                                         NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor orangeColor]];
    [shadow setShadowBlurRadius:2.0];
    [shadow setShadowOffset:CGSizeMake(-2, 2)];

    [attrString addAttribute:NSShadowAttributeName
                             value:shadow
                             range:NSMakeRange(0, [attrString length])];
    
    return attrString;
}

@end
