//
//  TableFetchRCDelegate.h
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableFetchRCDelegate : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, copy) void(^UpdateCellCallback)(UITableViewCell *cell, NSIndexPath *indexPath);

@property (nonatomic, assign, getter = isNeedSelectRowForCorrespondingInsertedObject) BOOL needSelectRowForCorrespondingInsertedObject;

@end
