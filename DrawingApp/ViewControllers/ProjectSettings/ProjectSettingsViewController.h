//
//  ProjectSettingsViewController.h
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectSettingsViewController : UIViewController

@property (nonatomic, copy) void(^DrawingObjectTypeDidUpdate)(void);

@end
