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
    
    if (isBegTouch) {
        if (self.drawingObjectType == DRAWING_OBJECT_TYPE_FREE) {
            self.curDrawingObject = [self createNewDrawingObject];
            [self.curDrawingObject addCGPoint:point];
        } else {
            self.firstTouchPoint = point;
        }
        return;
    } else {
        if (!self.curDrawingObject) {
            self.curDrawingObject = [self createNewDrawingObject];
        }
    }
    
    NSArray *points = self.curDrawingObject.pointsArray;
    
    if (self.drawingObjectType == DRAWING_OBJECT_TYPE_FREE) {
        [self.curDrawingObject addCGPoint:point];
    } else {
        if (points.count==0) {
            [self.curDrawingObject addCGPoint:self.firstTouchPoint];
        }
        else if (points.count==2) {
            [self.curDrawingObject removePoint:[points lastObject]];
        }
        [self.curDrawingObject addCGPoint:point];
    }
    
    if (isEndTouch) {
        self.curDrawingObject = nil;
        self.firstTouchPoint = CGPointZero;
        [[CoreDataSetup shared] saveContext];
    }
}

- (DrawingObject *)createNewDrawingObject
{
    DrawingObject *drawingObject = [CoreDataHelper createNewDrawingObjectInProject:self.project];

    drawingObject.type = @(self.drawingObjectType);

    //todo : grub all settings here and set to corresponding properties
    drawingObject.fillColor = nil;
    drawingObject.strokeColor = [UIColor blackColor];
    drawingObject.lineWidth = @(3);
    
    return drawingObject;
}

@end
