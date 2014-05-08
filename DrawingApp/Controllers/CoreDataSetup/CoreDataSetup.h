//
//  CoreDataSetup.h
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataSetup : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)shared;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
