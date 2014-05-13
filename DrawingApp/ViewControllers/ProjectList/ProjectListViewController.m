//
//  MasterViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectListViewController.h"
#import "ProjectDetailViewController.h"
#import "TableFetchRCDelegate.h"

@interface ProjectListViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) ProjectDetailViewController *detailViewController;
@property (strong, nonatomic) TableFetchRCDelegate *projectListFetchRCDelegate;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

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

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (ProjectDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self setupProjectListFetchRCDelegate];
    [self setupFetchedResultController];
}

- (void)insertNewObject:(id)sender
{
    Project *project = [CoreDataHelper createProjectWithWidth:300 height:300];
    [[CoreDataSetup shared] saveContext];
    
    self.detailViewController.project = project;
    [self.detailViewController editProject];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Project *project = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if (project == self.detailViewController.project) {
            self.detailViewController.project = nil;
        }
        [CoreDataHelper deleteProject:project];
        [[CoreDataSetup shared] saveContext];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Project *project = (Project *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    self.detailViewController.project = project;
}

#pragma mark - Fetched results controller

- (void)setupFetchedResultController
{
    self.fetchedResultsController = [CoreDataHelper fetchResultControllerForProjects];
    self.fetchedResultsController.delegate = self.projectListFetchRCDelegate;
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}

- (void)setupProjectListFetchRCDelegate
{
    WeakSelf
    
    self.projectListFetchRCDelegate = [TableFetchRCDelegate new];
    self.projectListFetchRCDelegate.needSelectRowForCorrespondingInsertedObject = YES;
    self.projectListFetchRCDelegate.tableView = self.tableView;
    
    [self.projectListFetchRCDelegate setUpdateCellCallback:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        [weakSelf configureCell:cell atIndexPath:indexPath];
    }];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Project *project = (Project *) [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = project.name;
}

@end
