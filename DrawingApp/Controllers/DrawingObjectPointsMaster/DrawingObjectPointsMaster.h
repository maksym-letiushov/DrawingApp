//
//  DrawingObjectPointsMaster.h
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "DrawingObject.h"
#import "DrawingGestureReceiver.h"

@interface DrawingObjectPointsMaster : NSObject <DrawingGestureReceiver>

+ (instancetype)drawingObjectPointsMasterForObjectType:(enum DRAWING_OBJECT_TYPE)drawingObjectType
                                             inProject:(Project *)project;

@end
