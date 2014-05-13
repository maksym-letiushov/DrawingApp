//
//  ProjectDrawingObjectsTableViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectDrawingObjectsTableViewController.h"
#import "TableFetchRCDelegate.h"

@interface ProjectDrawingObjectsTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) TableFetchRCDelegate *projectObjectsFetchRCDelegate;

@end

@implementation ProjectDrawingObjectsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    [self setupProjectObjectsFetchRCDelegate];
    [self setupFetchedResultsController];
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

- (void)setupFetchedResultsController
{
    self.fetchedResultsController = [CoreDataHelper fetchResultControllerForDrawingObjectsInProject:self.project];
    self.fetchedResultsController.delegate = self.projectObjectsFetchRCDelegate;
    [self.fetchedResultsController performFetch:nil];
    
    [self.tableView reloadData];
}

- (void)setupProjectObjectsFetchRCDelegate
{
    self.projectObjectsFetchRCDelegate = [TableFetchRCDelegate new];
    self.projectObjectsFetchRCDelegate.needSelectRowForCorrespondingInsertedObject = YES;
    self.projectObjectsFetchRCDelegate.tableView = self.tableView;
    [self.projectObjectsFetchRCDelegate setUpdateCellCallback:^(UITableViewCell *cell, NSIndexPath *indexPath) {
        
    }];
}

#pragma mark - Table view data source

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
        DrawingObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [self.project removeDrawingObjectsObject:object];
        [[CoreDataSetup shared] saveContext];
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.clipsToBounds = YES;
    DrawingObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object typeString];
}

@end
