//
//  DrawingPoint.m
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "DrawingPoint.h"

static __unsafe_unretained NSString *const xKey = @"x";
static __unsafe_unretained NSString *const yKey = @"y";

@implementation DrawingPoint

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.x forKey:xKey];
    [aCoder encodeInteger:self.y forKey:yKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.x = [aDecoder decodeIntegerForKey:xKey];
    self.y = [aDecoder decodeIntegerForKey:yKey];
    
    return self;
}


@end
