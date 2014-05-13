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
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    NSArray *points = [drawingObject pointsArray];
    if (!points.count) {
        return ;
    }

    [drawingObject.fillColor setFill];
    [drawingObject.strokeColor setStroke];

    UIBezierPath *bezierPath = nil;
    
    if ([drawingObject.type integerValue] == DRAWING_OBJECT_TYPE_FREE) {
        bezierPath = [UIBezierPath new];
        for (int i = 0; i < points.count; i++) {
            if (i==0) {
                [bezierPath moveToPoint:[(DrawingPoint *)points[i] CGPoint]];
            } else {
                [bezierPath addLineToPoint:[(DrawingPoint *)points[i] CGPoint]];
            }
        }
    } else if ([drawingObject.type integerValue] == DRAWING_OBJECT_TYPE_LINE) {
        bezierPath = [UIBezierPath new];
        [bezierPath moveToPoint:[(DrawingPoint *)points.firstObject CGPoint]];
        [bezierPath addLineToPoint:[(DrawingPoint *)points.lastObject CGPoint]];
    } else if ([drawingObject.type integerValue] == DRAWING_OBJECT_TYPE_RECTANGLE) {
        CGRect rect = [self rectForOvalOrRectangleForDrawingObject:drawingObject];
        bezierPath = [UIBezierPath bezierPathWithRect:rect];
    } else if ([drawingObject.type integerValue] == DRAWING_OBJECT_TYPE_OVAL) {
        CGRect rect = [self rectForOvalOrRectangleForDrawingObject:drawingObject];
        bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    }
    
    [bezierPath setLineWidth:[drawingObject.lineWidth integerValue]];
    
    [bezierPath fill];
    [bezierPath stroke];
    
    CGContextRestoreGState(context);
}

- (CGRect)rectForOvalOrRectangleForDrawingObject:(DrawingObject *)drawingObject
{
    NSArray *points = [drawingObject pointsArray];
    
    CGPoint firstPoint = [(DrawingPoint *)points.firstObject CGPoint];
    CGPoint lastPoint = [(DrawingPoint *)points.lastObject CGPoint];

    CGRect rect = CGRectZero;
    rect.origin.x = MIN(firstPoint.x, lastPoint.x);
    rect.origin.y = MIN(firstPoint.y, lastPoint.y);
    rect.size.width = ABS(firstPoint.x - lastPoint.x);
    rect.size.height = ABS(firstPoint.y - lastPoint.y);
    
    return rect;
}

- (void)saveProjectPreviewImage
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToURL:self.project.imageURL atomically:YES];
}

@end
