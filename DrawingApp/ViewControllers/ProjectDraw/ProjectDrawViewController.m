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
#import "ProjectDrawingObjectsTableViewController.h"
#import "TransformTouchesReceiverView.h"

@interface ProjectDrawViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultController;
@property (nonatomic, strong) ProjectPictureView *projectPictureView;
@property (nonatomic, strong) DrawingTouchesReceiverView *drawingTouchesReceiverView;
@property (nonatomic, strong) TransformTouchesReceiverView *transformTouchesReceiverView;
@property (nonatomic, strong) DrawingObjectPointsMaster *drawingObjectPointsMaster;
@property (nonatomic, strong) ProjectSettingsViewController *projectSettingsViewController;
@property (nonatomic, strong) ProjectDrawingObjectsTableViewController *projectDrawingObjectsViewController;
@property (nonatomic, weak) DrawingObject *selectedObject;

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
    [self setupProjectDrawingObjectsTableViewController];
    
    [self setSettingsHidden:NO];
    [self setDrawingObjectsHidded:YES];
}

#pragma mark - Button's Actions

- (void)done
{
    [self.projectPictureView saveProjectPreviewImage];
    
    self.EditingDone();
}

- (void)showHideSettingsWithButton:(UIButton *)button
{
    [self setDrawingObjectsHidded:YES];
    [self setSettingsHidden:button.selected];
}

- (void)showHideObjectsWithButton:(UIButton *)button
{
    [self setSettingsHidden:YES];
    [self setDrawingObjectsHidded:button.selected];
}

- (void)setSettingsHidden:(BOOL)hidden
{
    UIBarButtonItem *settingsItem = self.navigationItem.rightBarButtonItems[0];
    [(UIButton *)settingsItem.customView setSelected:!hidden];
    self.projectSettingsViewController.view.hidden = hidden;
}

- (void)setDrawingObjectsHidded:(BOOL)hidden
{
    UIBarButtonItem *settingsItem = self.navigationItem.rightBarButtonItems[1];
    [(UIButton *)settingsItem.customView setSelected:!hidden];
    self.projectDrawingObjectsViewController.view.hidden = hidden;
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

- (CGRect)drawingRect
{
    CGRect rect = self.view.bounds;
    rect.origin.y += self.topLayoutGuide.length;
    rect.size.height -= (self.topLayoutGuide.length + self.bottomLayoutGuide.length);
    return rect;
}

- (void)setupProjectPictureView
{
    self.projectPictureView = [[ProjectPictureView alloc] initWithFrame:[self drawingRect]];
    self.projectPictureView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.projectPictureView.project = self.project;
    [self.view addSubview:self.projectPictureView];
}

- (void)setupDrawingTouchesReceiverView
{
    self.drawingTouchesReceiverView = [[DrawingTouchesReceiverView alloc] initWithFrame:[self drawingRect]];
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
    self.projectSettingsViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)-200, self.topLayoutGuide.length, 200, 400);
    
    [self.projectSettingsViewController setDrawingObjectTypeUpdate:^{
        [weakSelf setupDrawingObjectPointsMaster];
    }];
    
    [self.projectSettingsViewController setDrawingInstrumentTypeUpdate:^{
        enum DRAW_INSTRUMENT_TYPE type = [ProjectSettings shared].drawInstrumentType;
        if (type == DRAW_INSTRUMENT_TYPE_DRAWING_OBJECT) {
            weakSelf.selectedObject = nil;
            weakSelf.projectPictureView.selectedObject = nil;
            [weakSelf.transformTouchesReceiverView removeFromSuperview];
            weakSelf.transformTouchesReceiverView = nil;
            weakSelf.drawingTouchesReceiverView.hidden = NO;    //in order to start receive touches
        } else if (type == DRAW_INSTRUMENT_TYPE_SELECTION) {
            weakSelf.drawingTouchesReceiverView.hidden = YES;   //in order to prevent receive touches
        }
        
        [weakSelf.projectPictureView setNeedsDisplay];
    }];
    
    [self.view addSubview:self.projectSettingsViewController.view];
}

- (void)setupProjectDrawingObjectsTableViewController
{
    WeakSelf;
    
    self.projectDrawingObjectsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"projectDrawingObjectsStoryboardID"];
    self.projectDrawingObjectsViewController.project = self.project;
    self.projectDrawingObjectsViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)-200, self.topLayoutGuide.length, 200, CGRectGetHeight(self.view.frame)-self.topLayoutGuide.length-self.bottomLayoutGuide.length);
    
    self.projectDrawingObjectsViewController.SelectDrawingObjectBlock = ^(DrawingObject *drawingObject) {
        [ProjectSettings shared].drawInstrumentType = DRAW_INSTRUMENT_TYPE_SELECTION;
        [weakSelf.projectSettingsViewController updateUI];
        weakSelf.selectedObject = drawingObject;
        weakSelf.projectPictureView.selectedObject = drawingObject;
        [weakSelf setupTransformTouchesReceiverViewForSelectedDrawingObject];
        weakSelf.drawingTouchesReceiverView.hidden = YES;
        [weakSelf.projectPictureView setNeedsDisplay];
    };
    
    self.projectDrawingObjectsViewController.DeleteDrawingObjectBlock = ^(DrawingObject *drawingObject) {
        if (weakSelf.selectedObject == drawingObject) {
            weakSelf.selectedObject = nil;
            [weakSelf.transformTouchesReceiverView removeFromSuperview];
            weakSelf.transformTouchesReceiverView = nil;
        }
    };
    
    [self.view addSubview:self.projectDrawingObjectsViewController.view];
}

- (void)setupTransformTouchesReceiverViewForSelectedDrawingObject
{
    WeakSelf;
    
    if (!self.selectedObject) {
        return ;
    }
    
    if (self.transformTouchesReceiverView) {
        [self.transformTouchesReceiverView removeFromSuperview];
    }
    
    CGRect frame = [self.selectedObject frameAcceptableForTouches];
    
    CGPoint translation = CGPointMake(self.selectedObject.translationX.floatValue, self.selectedObject.translationY.floatValue);
    
    self.transformTouchesReceiverView = [[TransformTouchesReceiverView alloc] initWithFrame:frame
                                                                                translation:translation
                                                                                      scale:self.selectedObject.scale.floatValue
                                                                                      angle:self.selectedObject.angle.floatValue];
    
    [self.transformTouchesReceiverView setTranslate:^(CGFloat tx, CGFloat ty) {
        weakSelf.selectedObject.translationX = @(tx);
        weakSelf.selectedObject.translationY = @(ty);
        [weakSelf.projectPictureView setNeedsDisplay];
    }];
    
    [self.transformTouchesReceiverView setScale:^(CGFloat scale) {
        weakSelf.selectedObject.scale = @(scale);
        [weakSelf.projectPictureView setNeedsDisplay];
    }];
    
    [self.transformTouchesReceiverView setRotate:^(CGFloat angle) {
        weakSelf.selectedObject.angle = @(angle);
        [weakSelf.projectPictureView setNeedsDisplay];
    }];
    
    [self.transformTouchesReceiverView setTransformCompletionBlock:^{
        [[CoreDataSetup shared] saveContext];
    }];
    
    [self.projectPictureView addSubview:self.transformTouchesReceiverView];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.projectPictureView setNeedsDisplay];
}

@end
