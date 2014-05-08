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

@dynamic pointsData;
@dynamic lineWidth;
@dynamic strokeColorData;
@dynamic fillColorData;
@dynamic zIndex;
@dynamic hasStroke;
@dynamic hasFill;
@dynamic project;

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.pointsData = nil;
    self.lineWidth = @(LINE_WIDTH_MIN);
    self.strokeColorData = nil;
    self.fillColorData = nil;
    self.zIndex = @0;
    self.hasStroke = @YES;
    self.hasFill = @NO;
}

@end
