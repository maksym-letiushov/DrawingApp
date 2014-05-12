//
//  Project+ProjectAdditions.m
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "Project+ProjectAdditions.h"

@implementation Project (ProjectAdditions)

+ (NSString *)entityName
{
    return NSStringFromClass([Project class]);
}

+ (NSString *)keyDateCreated
{
    return @"dateCreated";
}

- (NSArray *)drawingObjectsSortedByZIndex
{
    NSArray *drawingObjects = [self.drawingObjects allObjects];
    
    drawingObjects = [drawingObjects sortedArrayUsingComparator:^NSComparisonResult(DrawingObject *obj1, DrawingObject * obj2) {
        return [obj1.zIndex compare:obj2.zIndex];
    }];
    
    return drawingObjects;
}

- (void)addDrawingObjectWithIncrementedZIndex:(DrawingObject *)value
{
    [self addDrawingObjectsObject:value];

    NSInteger lastZIndex = [self.lastZIndex integerValue];
    lastZIndex++;

    self.lastZIndex = @(lastZIndex);
    value.zIndex = self.lastZIndex;
}

@end
