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
#import "ProjectSettingsViewController.h"
#import "ProjectSettings.h"

@interface ProjectDrawViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) ProjectPictureView *projectPictureView;
@property (nonatomic, strong) DrawingTouchesReceiverView *drawingTouchesReceiverView;
@property (nonatomic, strong) DrawingObjectPointsMaster *drawingObjectPointsMaster;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultController;
@property (nonatomic, strong) ProjectSettingsViewController *projectSettingsViewController;

@end

@implementation ProjectDrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationItem];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (self.projectPictureView) {
        return;
    }
    
    [self setupProjectPictureView];
    [self setupDrawingTouchesReceiverView];
    [self setupDrawingObjectPointsMaster];
    [self setupFetchedResultController];
    [self setupProjectSettingsViewController];
    
    [self setSettingsHidden:NO];
}

#pragma mark - Button's Actions

- (void)done
{
    [self.projectPictureView saveProjectPreviewImage];
    
    self.EditingDone();
}

- (void)showHideSettingsWithButton:(UIButton *)button
{
    [self setSettingsHidden:button.selected];
}

- (void)showHideObjectsWithButton:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)setSettingsHidden:(BOOL)hidden
{
    UIBarButtonItem *settingsItem = self.navigationItem.rightBarButtonItems[0];
    [(UIButton *)settingsItem.customView setSelected:!hidden];
    self.projectSettingsViewController.view.hidden = hidden;
}

#pragma mark - Setup

- (void)setupNavigationItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone)
                                                                                          target:self
                                                                                          action:@selector(done)];
    
    UIBarButtonItem *settingsBarButtonItem = [ButtonsHelper twoStateBarButtonItemWithTitle:@"Settings"
                                                                                    target:self
                                                                                    action:@selector(showHideSettingsWithButton:)];
    
    UIBarButtonItem *objectsBarButtonItem = [ButtonsHelper twoStateBarButtonItemWithTitle:@"Objects"
                                                                                   target:self
                                                                                   action:@selector(showHideObjectsWithButton:)];
    
    self.navigationItem.rightBarButtonItems = @[settingsBarButtonItem, objectsBarButtonItem];
}

- (void)setupProjectPictureView
{
    self.projectPictureView = [[ProjectPictureView alloc] initWithFrame:self.view.bounds];
    self.projectPictureView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.projectPictureView.project = self.project;
    [self.view addSubview:self.projectPictureView];
}

- (void)setupDrawingTouchesReceiverView
{
    self.drawingTouchesReceiverView = [[DrawingTouchesReceiverView alloc] initWithFrame:self.view.bounds];
    self.drawingTouchesReceiverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.drawingTouchesReceiverView.drawingGestureReceiver = nil;
    [self.view addSubview:self.drawingTouchesReceiverView];
}

- (void)setupDrawingObjectPointsMaster
{
    enum DRAWING_OBJECT_TYPE type = [ProjectSettings shared].drawObjectType;
    
    self.drawingObjectPointsMaster = [DrawingObjectPointsMaster drawingObjectPointsMasterForObjectType:type inProject:self.project];
    self.drawingTouchesReceiverView.drawingGestureReceiver = self.drawingObjectPointsMaster;
}

- (void)setupFetchedResultController
{
    self.fetchedResultController = [CoreDataHelper fetchResultControllerForDrawingObjectsInProject:self.project];
    self.fetchedResultController.delegate = self;
    [self.fetchedResultController performFetch:nil];
}

- (void)setupProjectSettingsViewController
{
    WeakSelf;

    self.projectSettingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"projectSettingsStoryboardID"];
    self.projectSettingsViewController.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.projectSettingsViewController.view setFrame:CGRectMake(CGRectGetWidth(self.view.frame)-200, self.topLayoutGuide.length, 200, 400)];
    
    [self.projectSettingsViewController setDrawingObjectTypeDidUpdate:^{
        [weakSelf setupDrawingObjectPointsMaster];
    }];
    
    [self.view addSubview:self.projectSettingsViewController.view];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.projectPictureView setNeedsDisplay];
}

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
