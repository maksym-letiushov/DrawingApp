//
//  Project.h
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrawingObject;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * lastZIndex;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSSet *drawingObjects;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addDrawingObjectsObject:(DrawingObject *)value;
- (void)removeDrawingObjectsObject:(DrawingObject *)value;
- (void)addDrawingObjects:(NSSet *)values;
- (void)removeDrawingObjects:(NSSet *)values;

@end
