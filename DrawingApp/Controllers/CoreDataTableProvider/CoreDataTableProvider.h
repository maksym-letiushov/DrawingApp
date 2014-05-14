//
//  CoreDataTableProvider.h
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ConfigureCellBlock)(UITableViewCell *cell, NSIndexPath *indexPath, id modelObject);
typedef void(^AttemptDeleteObjectBlock)(NSIndexPath *indexPath, id modelObject);
typedef NSString *(^CellReuseIdentifierBlock)(NSIndexPath *indexPath, id modelObject);
typedef void(^SelectRowBlock)(NSIndexPath *indexPath, id modelObject);


@interface CoreDataTableProvider : NSObject

- (instancetype)initWithTableView:(UITableView *)tableView
          fetchedResultController:(NSFetchedResultsController *)fetchedResultController;

@property (nonatomic, weak, readonly) UITableView *tableView;
@property (nonatomic, weak, readonly) NSFetchedResultsController *fetchedRC;

@property (nonatomic, copy) ConfigureCellBlock ConfigureCellBlock;
@property (nonatomic, copy) AttemptDeleteObjectBlock AttemptDeleteObjectBlock;
@property (nonatomic, copy) CellReuseIdentifierBlock CellReuseIdentifierBlock;
@property (nonatomic, copy) SelectRowBlock SelectRowBlock;

@property (nonatomic, assign) BOOL editingAllowed;
@property (nonatomic, assign) BOOL reorderAllowed;
@property (nonatomic, assign) BOOL shouldSelectRowForNewlyInsertedObject;

@end
