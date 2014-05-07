//
//  DrawingObject.h
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface DrawingObject : NSManagedObject

@property (nonatomic, retain) NSData * points;
@property (nonatomic, retain) NSNumber * lineWidth;
@property (nonatomic, retain) NSData * strokeColor;
@property (nonatomic, retain) NSData * fillColor;
@property (nonatomic, retain) NSNumber * zIndex;
@property (nonatomic, retain) NSNumber * hasStroke;
@property (nonatomic, retain) NSNumber * hasFill;
@property (nonatomic, retain) Project *project;

@end
