//
//  ProjectSettings.m
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectSettings.h"

static ProjectSettings *shared = nil;

@implementation ProjectSettings

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [self new];
    });
    
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.drawInstrumentType = DRAW_INSTRUMENT_TYPE_DRAWING_OBJECT;
        self.drawObjectType = DRAWING_OBJECT_TYPE_FREE;
        self.lineWidth = 1;
        self.strokeColor = [UIColor greenColor];
        self.fillColor = [UIColor grayColor];
    }
    return self;
}

@end
