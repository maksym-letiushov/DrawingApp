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

- (NSString *)typeString
{
    switch (self.type.integerValue) {
        case DRAWING_OBJECT_TYPE_FREE:
            return @"Free";
        case DRAWING_OBJECT_TYPE_LINE:
            return @"Line";
        case DRAWING_OBJECT_TYPE_RECTANGLE:
            return @"Rectangle";
        case DRAWING_OBJECT_TYPE_OVAL:
            return @"Oval";
    }
    return @"";
}

- (CGPoint)center
{
    NSInteger minX=NSIntegerMax, minY=NSIntegerMax;
    NSInteger maxX=NSIntegerMin, maxY=NSIntegerMin;
    
    NSArray *points = self.pointsArray;
    for (DrawingPoint *drawingPoint in points) {
        CGPoint point = [drawingPoint CGPoint];
        if (point.x < minX) {
            minX = point.x;
        }
        if (point.y < minY) {
            minY = point.y;
        }
        if (point.x > maxX) {
            maxX = point.x;
        }
        if (point.y > maxY) {
            maxY = point.y;
        }
    }
    return CGPointMake((minX+maxX)/2, (minY+maxY)/2);
}

- (BOOL)hasAffineTransformations
{
    return (self.scale.integerValue > 1) || (self.angle.floatValue != 0.0) || (self.translationX.floatValue !=0.0) || (self.translationY.floatValue !=0.0);
}

@end
