//
//  MasterViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectListViewController.h"
#import "ProjectDetailViewController.h"
#import "CoreDataTableProvider.h"

@interface ProjectListViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) ProjectDetailViewController *detailViewController;
@property (strong, nonatomic) CoreDataTableProvider *projectListTableProvider;

@end

@implementation ProjectListViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(insertNewObject:)];
    
    self.detailViewController = (ProjectDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self setupProjectListTableProvider];
}

- (void)insertNewObject:(id)sender
{
    Project *project = [CoreDataHelper createProjectWithWidth:300 height:300];
    [[CoreDataSetup shared] saveContext];
    
    self.detailViewController.project = project;
    [self.detailViewController editProject];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [CoreDataHelper fetchResultControllerForProjects];
    }
    return _fetchedResultsController;
}

#pragma mark - Fetched results controller

- (void)setupProjectListTableProvider
{
    WeakSelf;
    
    self.projectListTableProvider = [[CoreDataTableProvider alloc] initWithTableView:self.tableView fetchedResultController:self.fetchedResultsController];
    self.projectListTableProvider.editingAllowed = YES;
    self.projectListTableProvider.reorderAllowed = NO;
    self.projectListTableProvider.shouldSelectRowForNewlyInsertedObject = YES;
    
    self.projectListTableProvider.CellReuseIdentifierBlock = ^(NSIndexPath *indexPath, Project *project) {
        return @"Cell";
    };
    
    self.projectListTableProvider.ConfigureCellBlock = ^(UITableViewCell *cell, NSIndexPath *indexPath, Project *project) {
        cell.textLabel.text = project.name;
    };
    
    self.projectListTableProvider.AttemptDeleteObjectBlock = ^(NSIndexPath *indexPath, Project *project) {
        if (project == weakSelf.detailViewController.project) {
            weakSelf.detailViewController.project = nil;
        }
        [CoreDataHelper deleteProject:project];
        [[CoreDataSetup shared] saveContext];
    };
    self.projectListTableProvider.SelectRowBlock = ^(NSIndexPath *indexPath, Project *project) {
        weakSelf.detailViewController.project = project;
    };
}

@end
