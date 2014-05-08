//
//  CoreDataHelper.h
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "DrawingObject.h"

@interface CoreDataHelper : NSObject

+ (NSArray *)allProjects;

+ (NSInteger)projectsCount;

+ (Project *)createProject;
+ (DrawingObject *)createDrawingObject;

@end
