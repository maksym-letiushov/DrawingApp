//
//  ButtonsHelper.h
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonsHelper : NSObject

+ (UIBarButtonItem *)twoStateBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
