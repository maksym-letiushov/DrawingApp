//
//  DrawingObjectPointsMaster.m
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "DrawingObjectPointsMaster.h"

@interface DrawingObjectPointsMaster ()

@property (nonatomic, assign) enum DRAWING_OBJECT_TYPE drawingObjectType;
@property (nonatomic, weak) Project *project;
@property (nonatomic, weak) DrawingObject *curDrawingObject;

@property (nonatomic, assign) CGPoint firstTouchPoint;

@end

@implementation DrawingObjectPointsMaster

+ (instancetype)drawingObjectPointsMasterForObjectType:(enum DRAWING_OBJECT_TYPE)drawingObjectType
                                             inProject:(Project *)project
{
    DrawingObjectPointsMaster *master = [DrawingObjectPointsMaster new];

    master.drawingObjectType = drawingObjectType;
    master.project = project;
    
    return master;
}

- (void)updateWithTouchInPoint:(CGPoint)point isBegTouch:(BOOL)isBegTouch isEndTouch:(BOOL)isEndTouch
{    
    if (!self.project) {
        return;
    }
    
    BOOL isTwoPointsNeed = !(self.drawingObjectType == DRAWING_OBJECT_TYPE_FREE);
    
    DrawingObject *drawingObject = nil;
    if (isBegTouch) {
        if (isTwoPointsNeed) {
            self.firstTouchPoint = point;
            return;
        } else {
            drawingObject = [CoreDataHelper createNewDrawingObjectInProject:self.project];
            drawingObject.type = @(self.drawingObjectType);
            drawingObject.fillColor = nil;
            drawingObject.strokeColor = [UIColor blackColor];
            drawingObject.lineWidth = @(3);
            self.curDrawingObject = drawingObject;
        }
    } else {
        drawingObject = self.curDrawingObject;
    }
    
    NSArray *points = drawingObject.pointsArray;
    
    if (self.drawingObjectType == DRAWING_OBJECT_TYPE_FREE) {
        [drawingObject addCGPoint:point];
    } else {
        if (points.count==0 || points.count==1) {
            [drawingObject addCGPoint:point];
        } else {
            [drawingObject removePoint:[points lastObject]];
            [drawingObject addCGPoint:point];
        }
    }
    
    if (isEndTouch) {
        self.curDrawingObject = nil;
        self.firstTouchPoint = CGPointZero;
        [[CoreDataSetup shared] saveContext];
    }
}

@end
