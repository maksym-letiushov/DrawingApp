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

- (CGRect)frame
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
    
    return CGRectMake(minX, minY, maxX-minX,maxY-minY);
}

#define MIN_ACCEPTABLE_WIDTH_FOR_TOUCHES 200
#define MIN_ACCEPTABLE_HEIGHT_FOR_TOUCHES 200

- (CGRect)frameAcceptableForTouches
{
    CGRect frame = self.frame;
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    if (width < MIN_ACCEPTABLE_WIDTH_FOR_TOUCHES) {
        frame.size.width = MIN_ACCEPTABLE_WIDTH_FOR_TOUCHES;
        frame.origin.x -= (MIN_ACCEPTABLE_WIDTH_FOR_TOUCHES-width)/2;
    }
    if (height < MIN_ACCEPTABLE_HEIGHT_FOR_TOUCHES) {
        frame.size.height = MIN_ACCEPTABLE_HEIGHT_FOR_TOUCHES;
        frame.origin.y -= (MIN_ACCEPTABLE_HEIGHT_FOR_TOUCHES-height)/2;
    }
    
    return frame;
}

- (CGPoint)center
{
    CGRect frame = self.frame;
    return CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
}

- (BOOL)hasAffineTransformations
{
    return ((self.scale.floatValue != 1) ||
            (self.angle.floatValue != 0.0) ||
            (self.translationX.floatValue != 0.0) || (self.translationY.floatValue !=0.0));
}

@end
