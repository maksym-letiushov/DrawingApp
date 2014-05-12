//
//  CoreDataHelper.h
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Project.h"
#import "DrawingObject.h"

@interface CoreDataHelper : NSObject

+ (NSArray *)allProjects;

+ (NSInteger)projectsCount;

+ (Project *)createProjectWithWidth:(NSInteger)width height:(NSInteger)height;
+ (DrawingObject *)createNewDrawingObjectInProject:(Project *)project;

+ (void)deleteProject:(Project *)project;

+ (NSFetchedResultsController *)fetchResultControllerForProjects;
+ (NSFetchedResultsController *)fetchResultControllerForDrawingObjectsInProject:(Project *)project;

@end
