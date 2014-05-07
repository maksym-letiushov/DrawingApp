//
//  Project.m
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "Project.h"
#import "DrawingObject.h"


@implementation Project

@dynamic name;
@dynamic width;
@dynamic height;
@dynamic imageName;
@dynamic lastZIndex;
@dynamic dateCreated;
@dynamic drawingObjects;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.dateCreated = [NSDate date];
    self.lastZIndex = @0;
    self.height = @100;
    self.width = @100;
    self.name = [NSString stringWithFormat:@"Project"];
    self.imageName = nil;
}

@end
