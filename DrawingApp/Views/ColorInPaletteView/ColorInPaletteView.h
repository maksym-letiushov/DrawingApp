//
//  ColorInPaletteView.h
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorInPaletteView : UIView

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

@property (nonatomic, copy) void(^Tap)(void);

@end
