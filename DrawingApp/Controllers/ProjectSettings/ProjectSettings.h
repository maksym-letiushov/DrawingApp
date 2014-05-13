//
//  ProjectSettings.h
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectSettings : NSObject

+ (instancetype)shared;

@property (nonatomic, assign) enum DRAW_INSTRUMENT_TYPE drawInstrumentType;
@property (nonatomic, assign) enum DRAWING_OBJECT_TYPE drawObjectType;
@property (nonatomic, assign) NSInteger lineWidth;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

@end
