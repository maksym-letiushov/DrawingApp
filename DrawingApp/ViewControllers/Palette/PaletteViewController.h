//
//  PaletteViewController.h
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaletteViewController : UIViewController

@property (nonatomic, copy) void(^UpdateColor)(UIColor *color);

+ (CGSize)prefferedSize;

@end
