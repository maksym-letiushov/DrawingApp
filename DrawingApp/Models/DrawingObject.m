//
//  DrawingObject.m
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "DrawingObject.h"
#import "Project.h"


@implementation DrawingObject

@dynamic points;
@dynamic lineWidth;
@dynamic strokeColor;
@dynamic fillColor;
@dynamic zIndex;
@dynamic hasStroke;
@dynamic hasFill;
@dynamic project;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.points = nil;
    self.lineWidth = @1;
    self.strokeColor = nil;
    self.fillColor = nil;
    self.zIndex = @0;
    self.hasStroke = @YES;
    self.hasFill = @NO;
}

@end
