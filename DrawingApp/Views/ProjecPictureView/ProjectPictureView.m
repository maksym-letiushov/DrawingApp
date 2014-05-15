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

- (void)setProject:(Project *)project
{
    _project = project;
    [self setNeedsDisplay];
}

- (void)setSelectedObject:(DrawingObject *)selectedObject
{
    _selectedObject = selectedObject;
    [self setNeedsDisplay];
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
    
    if (drawingObject.hasAffineTransformations) {
        CGPoint center = drawingObject.center;
        
        if (drawingObject.translationX.floatValue != 0.0 || drawingObject.translationY.floatValue != 0.0) {
            // make translation for center and all points
            center = [self translatedPoint:center
                                        tx:drawingObject.translationX.floatValue
                                        ty:drawingObject.translationY.floatValue];
            points = [self translateDrawingPointsForDrawingObject:drawingObject];
        }
        
        
        // translate points to make center of coordinate system in the center of object
        points = [self translateDrawingPoints:points toCoordinateSystemWithCenter:center];
        CGContextTranslateCTM(context, center.x, center.y);
        
        //scale
        if (drawingObject.scale.floatValue != 0) {
            CGContextScaleCTM(context, drawingObject.scale.floatValue, drawingObject.scale.floatValue);
        }
        
        //rotation
        if (drawingObject.angle.floatValue != 0) {
            CGContextRotateCTM(context, drawingObject.angle.floatValue);
        }
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
        CGRect rect = [self rectForOvalOrRectangleFromPoints:points];
        bezierPath = [UIBezierPath bezierPathWithRect:rect];
    } else if ([drawingObject.type integerValue] == DRAWING_OBJECT_TYPE_OVAL) {
        CGRect rect = [self rectForOvalOrRectangleFromPoints:points];
        bezierPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    }
    
    [bezierPath setLineWidth:[drawingObject.lineWidth integerValue]];
    
    if (drawingObject == self.selectedObject) {
        //// Shadow Declarations
        UIColor* shadow = [UIColor redColor];
        CGSize shadowOffset = CGSizeMake(0.1, -0.1);
        CGFloat shadowBlurRadius = 15;
        
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
    }
    
    [bezierPath fill];
    [bezierPath stroke];
    
    CGContextRestoreGState(context);
}

- (CGRect)rectForOvalOrRectangleFromPoints:(NSArray *)points
{
    CGPoint firstPoint = [(DrawingPoint *)points.firstObject CGPoint];
    CGPoint lastPoint = [(DrawingPoint *)points.lastObject CGPoint];

    CGRect rect = CGRectZero;
    rect.origin.x = MIN(firstPoint.x, lastPoint.x);
    rect.origin.y = MIN(firstPoint.y, lastPoint.y);
    rect.size.width = ABS(firstPoint.x - lastPoint.x);
    rect.size.height = ABS(firstPoint.y - lastPoint.y);
    
    return rect;
}

- (NSArray *)translateDrawingPointsForDrawingObject:(DrawingObject *)object
{
    NSArray *points = [object pointsArray];
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:points.count];
    for (DrawingPoint *drawingPoint in points) {
        CGPoint translatedPoint = [self translatedPoint:[drawingPoint CGPoint]
                                                     tx:object.translationX.floatValue
                                                     ty:object.translationY.floatValue];
        
        DrawingPoint *translatedDrawingPoint = [DrawingPoint pointFromCGPoint:translatedPoint];
        [results addObject:translatedDrawingPoint];
    }
    return results;
}

- (CGPoint)translatedPoint:(CGPoint)point tx:(CGFloat)tx ty:(CGFloat)ty
{
    point.x += tx;
    point.y += ty;
    
    return point;
}

- (NSArray *)translateDrawingPoints:(NSArray *)drawingPoints toCoordinateSystemWithCenter:(CGPoint)center
{
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:drawingPoints.count];
    for (DrawingPoint *drawingPoint in drawingPoints) {
        CGPoint translatedPoint = [self translatePoint:[drawingPoint CGPoint] toCoordinateSystemWithCenter:center];
        DrawingPoint *translatedDrawingPoint = [DrawingPoint pointFromCGPoint:translatedPoint];
        [results addObject:translatedDrawingPoint];
    }
    return results;
}

- (CGPoint)translatePoint:(CGPoint)point toCoordinateSystemWithCenter:(CGPoint)center
{
    return CGPointMake(point.x-center.x, point.y-center.y);
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
