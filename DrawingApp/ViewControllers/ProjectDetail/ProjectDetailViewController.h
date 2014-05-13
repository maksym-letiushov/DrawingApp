//
//  DetailViewController.h
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) Project *project;

@end
