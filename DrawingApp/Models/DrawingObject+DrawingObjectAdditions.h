//
//  DrawingObject+DrawingObjectAdditions.h
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "DrawingObject.h"
#import "DrawingObject.h"

@interface DrawingObject (DrawingObjectAdditions)

+ (NSString *)entityName;

- (NSArray *)pointsArray;   //of DrawingPoint
- (UIColor *)strokeColor;
- (UIColor *)fillColor;

- (void)setPointsArray:(NSArray *)pointsArray;  //of DrawingPoint
- (void)setFillColor:(UIColor *)color;
- (void)setStrokeColor:(UIColor *)color;

@end
