//
//  ProjectPictureView.h
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface ProjectPictureView : UIView

@property (nonatomic, weak) Project *project;

@property (nonatomic, weak) DrawingObject *selectedObject;

- (void)saveProjectPreviewImage;

@end
