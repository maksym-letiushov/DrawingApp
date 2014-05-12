//
//  DetailViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/7/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "ProjectDrawViewController.h"

@interface ProjectDetailViewController ()

//@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) Project *project;
@property (strong, nonatomic) UINavigationController *projectDrawNC;

@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

@end

@implementation ProjectDetailViewController

- (void)showDetailsOfProject:(Project *)project
{
    _project = project;
    
    [self updateUI];
}

- (void)updateUI
{
    if (![self isViewLoaded]) {
        return ;
    }
    
    if (self.project.imageName.length) {
        self.previewImageView.image = [UIImage imageWithContentsOfFile:self.project.imageName];
    }
    
    if (self.project) {
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemEdit) target:self action:@selector(editProject)];

        self.navigationItem.leftBarButtonItem = editButton;
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

//#pragma mark - Managing the detail item
//
//- (void)setDetailItem:(id)newDetailItem
//{
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
//
//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
//    }        
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateUI];
}

- (void)editProject
{
    ProjectDrawViewController *projectDrawVC = [self.storyboard instantiateViewControllerWithIdentifier:@"projectDrawStoryboardID"];
    projectDrawVC.project = self.project;
    [projectDrawVC setEditingDone:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:projectDrawVC];
    nc.modalPresentationStyle = UIModalPresentationFullScreen;
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    self.projectDrawNC = nc;
    
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - Split view

//- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
//{
//    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
//    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
//    self.masterPopoverController = popoverController;
//}
//
//- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    // Called when the view is shown again in the split view, invalidating the button and popover controller.
//    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
//    self.masterPopoverController = nil;
//}

@end
