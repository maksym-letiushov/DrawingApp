//
//  RGBAColor.h
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGBAColor : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger red;
@property (nonatomic, assign) NSInteger green;
@property (nonatomic, assign) NSInteger blue;
@property (nonatomic, assign) double alpha;

+ (RGBAColor *)RGBAColorFromUIColor:(UIColor *)color;

- (UIColor *)color;

@end
