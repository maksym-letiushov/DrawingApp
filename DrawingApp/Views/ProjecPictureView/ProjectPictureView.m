//
//  ProjectPictureView.m
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectPictureView.h"
#import "DrawingPoint.h"

@implementation ProjectPictureView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = nil;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //NSLog(@"%s",__FUNCTION__);
    
    if (!self.project) {
        //todo fill background
        return ;
    }
    
    NSArray *drawingObjects = [self.project drawingObjectsSortedByZIndex];
    
    for (DrawingObject *drawingObj in drawingObjects) {
        
        [self drawObject:drawingObj];
    }
}

- (void)drawObject:(DrawingObject *)drawingObject
{
    NSArray *points = [drawingObject pointsArray];
    if (!points.count) {
        return ;
    }

    [drawingObject.fillColor setFill];
    [drawingObject.strokeColor setStroke];

    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath setLineWidth:[drawingObject.lineWidth integerValue]];
    
    if ([drawingObject.type integerValue] == DRAWING_OBJECT_TYPE_FREE) {
        for (int i = 0; i < points.count; i++) {
            if (i==0) {
                [bezierPath moveToPoint:[(DrawingPoint *)points[i] CGPoint]];
            } else {
                [bezierPath addLineToPoint:[(DrawingPoint *)points[i] CGPoint]];
            }
        }
    } else if ([drawingObject.type integerValue] == DRAWING_OBJECT_TYPE_LINE) {
        
    }
    
    [bezierPath fill];
    [bezierPath stroke];
}

@end
