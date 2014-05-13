//
//  DrawingObject+DrawingObjectAdditions.m
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "DrawingObject+DrawingObjectAdditions.h"
#import "DrawingPoint.h"
#import "RGBAColor.h"

@implementation DrawingObject (DrawingObjectAdditions)

+ (NSString *)entityName
{
    return NSStringFromClass([DrawingObject class]);
}

+ (NSString *)keyZIndex
{
    return @"zIndex";
}

- (NSArray *)pointsArray   //of Point
{
    if (!self.pointsData) {
        return @[];
    }

    return [NSKeyedUnarchiver unarchiveObjectWithData:self.pointsData];
}

- (UIColor *)strokeColor
{
    if (!self.strokeColorData) {
        return nil;
    }
    
    RGBAColor *rgbaColor = [NSKeyedUnarchiver unarchiveObjectWithData:self.strokeColorData];
    return [rgbaColor color];
}

- (UIColor *)fillColor
{
    if (!self.fillColorData) {
        return nil;
    }
    
    RGBAColor *rgbaColor = [NSKeyedUnarchiver unarchiveObjectWithData:self.fillColorData];
    return [rgbaColor color];
}

- (void)setPointsArray:(NSArray *)pointsArray  //of DrawingPoint
{
    self.pointsData = [NSKeyedArchiver archivedDataWithRootObject:pointsArray];
}

- (void)setFillColor:(UIColor *)color
{
    RGBAColor *rgbaColor = [RGBAColor RGBAColorFromUIColor:color];
    self.fillColorData = [NSKeyedArchiver archivedDataWithRootObject:rgbaColor];
}

- (void)setStrokeColor:(UIColor *)color
{
    RGBAColor *rgbaColor = [RGBAColor RGBAColorFromUIColor:color];
    self.strokeColorData = [NSKeyedArchiver archivedDataWithRootObject:rgbaColor];
}

- (void)addCGPoint:(CGPoint)cgPoint
{
    NSMutableArray *points = [NSMutableArray arrayWithArray:[self pointsArray]];
    [points addObject:[DrawingPoint pointFromCGPoint:cgPoint]];
    [self setPointsArray:points];
}

- (void)removePoint:(DrawingPoint *)point
{
    NSMutableArray *points = [NSMutableArray arrayWithArray:[self pointsArray]];
    [points removeObject:point];
    [self setPointsArray:points];
}

@end
