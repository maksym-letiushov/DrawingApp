//
//  Project+ProjectAdditions.h
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "Project.h"

@interface Project (ProjectAdditions)

+ (NSString *)entityName;

+ (NSString *)keyDateCreated;

- (NSArray *)drawingObjectsSortedByZIndex;

- (void)addDrawingObjectWithIncrementedZIndex:(DrawingObject *)value;

@end
