//
//  MasterViewController.h
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProjectDetailViewController;

#import <CoreData/CoreData.h>

@interface ProjectListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) ProjectDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
