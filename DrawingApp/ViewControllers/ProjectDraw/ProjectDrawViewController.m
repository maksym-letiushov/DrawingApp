//
//  ProjectDrawViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectDrawViewController.h"
#import "ProjectPictureView.h"
#import "DrawingTouchesReceiverView.h"
#import "DrawingObjectPointsMaster.h"

@interface ProjectDrawViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) ProjectPictureView *projectPictureView;
@property (nonatomic, strong) DrawingTouchesReceiverView *drawingTouchesReceiverView;
@property (nonatomic, strong) DrawingObjectPointsMaster *drawingObjectPointsMaster;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultController;

@end


@implementation ProjectDrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentDrawInstrumentType = DRAW_INSTRUMENT_TYPE_DRAWING_OBJECT;
    self.currentDrawObjectType = DRAWING_OBJECT_TYPE_FREE;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(done)];
    
    [self setupProjectPictureView];
    [self setupDrawingTouchesReceiverView];
    [self setupDrawingObjectPointsMaster];
    [self setupFetchedResultController];
}

- (void)done
{
    self.EditingDone();
}

#pragma mark - Setup

- (void)setupProjectPictureView
{
    self.projectPictureView = [[ProjectPictureView alloc] initWithFrame:self.view.bounds];
    self.projectPictureView.project = self.project;
    
    [self.view addSubview:self.projectPictureView];
}

- (void)setupDrawingTouchesReceiverView
{
    self.drawingTouchesReceiverView = [[DrawingTouchesReceiverView alloc] initWithFrame:self.view.bounds];
    self.drawingTouchesReceiverView.drawingGestureReceiver = nil;
    [self.view addSubview:self.drawingTouchesReceiverView];
}

- (void)setupDrawingObjectPointsMaster
{
    self.drawingObjectPointsMaster = [DrawingObjectPointsMaster drawingObjectPointsMasterForObjectType:self.currentDrawObjectType inProject:self.project];
    self.drawingTouchesReceiverView.drawingGestureReceiver = self.drawingObjectPointsMaster;
}

- (void)setupFetchedResultController
{
    self.fetchedResultController = [CoreDataHelper fetchResultControllerForDrawingObjectsInProject:self.project];
    self.fetchedResultController.delegate = self;
    [self.fetchedResultController performFetch:nil];
}

#pragma mark - NSFetchedResultsControllerDelegate

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"%s",__FUNCTION__);
    [self.projectPictureView setNeedsDisplay];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
