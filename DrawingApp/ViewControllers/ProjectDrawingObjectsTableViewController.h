//
//  ProjectDrawingObjectsTableViewController.h
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDrawingObjectsTableViewController : UITableViewController

@property (nonatomic, weak) Project *project;

@property (nonatomic, copy) void(^SelectDrawingObjectBlock)(DrawingObject *drawingObject);

@property (nonatomic, copy) void(^DeleteDrawingObjectBlock)(DrawingObject *drawingObject);

@end
