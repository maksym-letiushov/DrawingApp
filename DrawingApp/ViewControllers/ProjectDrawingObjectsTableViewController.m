//
//  ProjectDrawingObjectsTableViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectDrawingObjectsTableViewController.h"
#import "CoreDataTableProvider.h"

@interface ProjectDrawingObjectsTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) CoreDataTableProvider *projectObjectsTableProvider;

@end

@implementation ProjectDrawingObjectsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupProjectObjectsTableProvider];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.view.layer.masksToBounds = NO;
    self.view.layer.shadowColor = [UIColor orangeColor].CGColor;
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowRadius = 5;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [CoreDataHelper fetchResultControllerForDrawingObjectsInProject:self.project];
    }
    return _fetchedResultsController;
}

- (void)setupProjectObjectsTableProvider
{
    WeakSelf;
    
    self.projectObjectsTableProvider = [[CoreDataTableProvider alloc] initWithTableView:self.tableView fetchedResultController:self.fetchedResultsController];
    
    self.projectObjectsTableProvider.editingAllowed = YES;
    self.projectObjectsTableProvider.reorderAllowed = NO;
    self.projectObjectsTableProvider.shouldSelectRowForNewlyInsertedObject = YES;
    
    self.projectObjectsTableProvider.CellReuseIdentifierBlock = ^(NSIndexPath *indexPath, DrawingObject *drawingObject) {
        return @"Cell";
    };
    
    self.projectObjectsTableProvider.ConfigureCellBlock = ^(UITableViewCell *cell, NSIndexPath *indexPath, DrawingObject *drawingObject) {
        cell.clipsToBounds = YES;
        cell.textLabel.text = [drawingObject typeString];
    };
    
    self.projectObjectsTableProvider.AttemptDeleteObjectBlock = ^(NSIndexPath *indexPath, DrawingObject *drawingObject) {
        [weakSelf.project removeDrawingObjectsObject:drawingObject];
        [[CoreDataSetup shared] saveContext];
    };
    self.projectObjectsTableProvider.SelectRowBlock = ^(NSIndexPath *indexPath, DrawingObject *drawingObject) {
        if (weakSelf.SelectDrawingObjectBlock) {
            weakSelf.SelectDrawingObjectBlock(drawingObject);
        }
    };
}

@end
