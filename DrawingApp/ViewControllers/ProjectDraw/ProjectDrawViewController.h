//
//  ProjectDrawViewController.h
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDrawViewController : UIViewController

@property (nonatomic, weak) Project *project;

@property (nonatomic, copy) void(^EditingDone)(void);

@property (nonatomic, assign) enum DRAW_INSTRUMENT_TYPE currentDrawInstrumentType;
@property (nonatomic, assign) enum DRAWING_OBJECT_TYPE currentDrawObjectType;

@end
