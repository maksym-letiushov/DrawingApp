//
//  DrawingObject+DrawingObjectAdditions.h
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "DrawingObject.h"
#import "DrawingObject.h"

#import "DrawingPoint.h"

@interface DrawingObject (DrawingObjectAdditions)

+ (NSString *)entityName;

+ (NSString *)keyZIndex;//zIndex

- (NSArray *)pointsArray;   //of DrawingPoint
- (UIColor *)strokeColor;
- (UIColor *)fillColor;

- (void)setPointsArray:(NSArray *)pointsArray;  //of DrawingPoint
- (void)setFillColor:(UIColor *)color;
- (void)setStrokeColor:(UIColor *)color;

- (void)addCGPoint:(CGPoint)cgPoint;

- (void)removePoint:(DrawingPoint *)point;

- (NSString *)typeString;

@end

