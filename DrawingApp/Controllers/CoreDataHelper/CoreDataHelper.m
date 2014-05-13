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
    fetchRequest.sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:[Project keyDateCreated] ascending:NO];
    
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

+ (Project *)createProjectWithWidth:(NSInteger)width height:(NSInteger)height
{
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:[Project entityName]
                                                     inManagedObjectContext:[CoreDataSetup shared].managedObjectContext];
    
    project.name = [NSString stringWithFormat:@"Untitled Project"];
    project.dateCreated = [NSDate date];
    project.width = @(width);
    project.height = @(height);
    project.lastZIndex = @(0);
    
    return project;
}

+ (DrawingObject *)createNewDrawingObjectInProject:(Project *)project
{
    DrawingObject *drawingObject = [NSEntityDescription insertNewObjectForEntityForName:[DrawingObject entityName]
                                                                   inManagedObjectContext:[CoreDataSetup shared].managedObjectContext];
    
    [project addDrawingObjectWithIncrementedZIndex:drawingObject];

    return drawingObject;
}

+ (void)deleteProject:(Project *)project
{
    if ([project isKindOfClass:[Project class]]) {
        [[CoreDataSetup shared].managedObjectContext deleteObject:project];
    }
}

+ (NSFetchedResultsController *)fetchResultControllerForProjects
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[Project entityName]];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:[Project keyDateCreated] ascending:NO]];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    
    NSFetchedResultsController *fetchedRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                 managedObjectContext:[CoreDataSetup shared].managedObjectContext
                                                                                   sectionNameKeyPath:nil                                                                                        cacheName:nil];
    
    return fetchedRC;
}

+ (NSFetchedResultsController *)fetchResultControllerForDrawingObjectsInProject:(Project *)project
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[DrawingObject entityName]];
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:[DrawingObject keyZIndex] ascending:YES]];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"project.dateCreated",project.dateCreated];
    
//    NSArray *results = [[CoreDataSetup shared].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSFetchedResultsController *fetchedRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:[CoreDataSetup shared].managedObjectContext
                                                                                  sectionNameKeyPath:nil                                                                                        cacheName:nil];
    
    return fetchedRC;
}


@end
