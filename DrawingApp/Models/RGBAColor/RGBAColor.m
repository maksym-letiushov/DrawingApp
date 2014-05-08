//
//  RGBAColor.m
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "RGBAColor.h"

static __unsafe_unretained NSString *const redKey = @"red";
static __unsafe_unretained NSString *const greenKey = @"green";
static __unsafe_unretained NSString *const blueKey = @"blue";
static __unsafe_unretained NSString *const alphaKey = @"alpha";

@implementation RGBAColor

+ (RGBAColor *)RGBAColorFromUIColor:(UIColor *)color
{
    float red=0, green=0, blue=0, alpha=0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    RGBAColor *rgbaColor = [RGBAColor new];
    
    rgbaColor.red = red * 255.0;
    rgbaColor.green = green *255.0;
    rgbaColor.blue = blue * 255.0;
    rgbaColor.alpha = alpha;
    
    return rgbaColor;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.red forKey:redKey];
    [aCoder encodeInteger:self.green forKey:greenKey];
    [aCoder encodeInteger:self.blue forKey:blueKey];
    [aCoder encodeDouble:self.alpha forKey:alphaKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.red = [aDecoder decodeIntegerForKey:redKey];
    self.green = [aDecoder decodeIntegerForKey:greenKey];
    self.blue = [aDecoder decodeIntegerForKey:blueKey];
    self.alpha = [aDecoder decodeDoubleForKey:alphaKey];
    
    return self;
}

- (UIColor *)color
{
    return [UIColor colorWithRed:self.red/255.0 green:self.green/255.0 blue:self.blue/255.0 alpha:self.alpha];
}


@end
