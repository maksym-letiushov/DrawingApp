//
//  CoreDataHelper.m
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "CoreDataHelper.h"
#import "CoreDataSetup.h"
#import "Project.h"

@implementation CoreDataHelper

+ (NSArray *)allProjects
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[Project entityName]];
    
    NSArray *resultArray = [[CoreDataSetup shared].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (!resultArray) {
        resultArray = @[];
    }
    
    return resultArray;
}

+ (NSInteger)projectsCount
{
    return [self allProjects].count;
}

+ (Project *)createProject
{
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:[Project entityName]
                                                     inManagedObjectContext:[CoreDataSetup shared].managedObjectContext];
    return project;
}

+ (DrawingObject *)createDrawingObject
{
    DrawingObject *drawingObject = [NSEntityDescription insertNewObjectForEntityForName:[DrawingObject entityName]
                                                                   inManagedObjectContext:[CoreDataSetup shared].managedObjectContext];
    return drawingObject;
}

@end
