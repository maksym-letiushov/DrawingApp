//
//  ProjectListFetchRCDelegate.h
//  DrawingApp
//
//  Created by Maxim on 5/8/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectListFetchRCDelegate : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) void(^UpdateCellCallback)(UITableViewCell *cell, NSIndexPath *indexPath);

@end
