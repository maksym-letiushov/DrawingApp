//
//  ProjectSettingsViewController.m
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ProjectSettingsViewController.h"
#import "ProjectSettings.h"
#import "ProjectSettings.h"
#import "LineWidthPickerDataSource.h"
#import "PaletteViewController.h"
#import "ColorInPaletteView.h"

@interface ProjectSettingsViewController () <UIPopoverControllerDelegate>

@property (nonatomic, strong) LineWidthPickerDataSource *lineWidthPickerDataSource;

@property (weak, nonatomic) IBOutlet UIButton *freeButton;
@property (weak, nonatomic) IBOutlet UIButton *lineButton;
@property (weak, nonatomic) IBOutlet UIButton *ovalButton;
@property (weak, nonatomic) IBOutlet UIButton *rectButton;
@property (weak, nonatomic) IBOutlet ColorInPaletteView *strokeColorView;
@property (weak, nonatomic) IBOutlet ColorInPaletteView *fillColorView;
@property (weak, nonatomic) IBOutlet UIPickerView *lineWidthPickerView;
@property (nonatomic, strong) UIPopoverController *popover;

- (IBAction)selectDrawingObjectTypeWithButton:(UIButton *)sender;

@end

@implementation ProjectSettingsViewController

- (void)setupUI
{
    self.freeButton.tag = DRAWING_OBJECT_TYPE_FREE;
    self.lineButton.tag = DRAWING_OBJECT_TYPE_LINE;
    self.ovalButton.tag = DRAWING_OBJECT_TYPE_OVAL;
    self.rectButton.tag = DRAWING_OBJECT_TYPE_RECTANGLE;

    [self selectDrawingObjectType:[ProjectSettings shared].drawObjectType];
    [self setupLineWidthPickerDataSource];

    
    self.strokeColorView.fillColor = [ProjectSettings shared].strokeColor;
    self.fillColorView.fillColor = [ProjectSettings shared].fillColor;
    
    WeakSelf;
    
    self.strokeColorView.Tap = ^{
        [weakSelf showPopoverWithCompletionHandler:^(UIColor *color) {
            weakSelf.strokeColorView.fillColor = color;
            [ProjectSettings shared].strokeColor = color;
        } fromRect:self.strokeColorView.frame];
    };
    
    self.fillColorView.Tap = ^{
        [weakSelf showPopoverWithCompletionHandler:^(UIColor *color) {
            weakSelf.fillColorView.fillColor = color;
            [ProjectSettings shared].fillColor = color;
        } fromRect:self.fillColorView.frame];
    };
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupLineWidthPickerDataSource
{
    self.lineWidthPickerDataSource = [[LineWidthPickerDataSource alloc] initWithPickerView:self.lineWidthPickerView];
    self.lineWidthPickerDataSource.lineWidth = [ProjectSettings shared].lineWidth;
    [self.lineWidthPickerDataSource setUpdateLineWidth:^(NSInteger lineWidth) {
        [ProjectSettings shared].lineWidth = lineWidth;
    }];
}

- (void)deselectAllDrawingObjectTypeButtons
{
    self.freeButton.selected = NO;
    self.lineButton.selected = NO;
    self.ovalButton.selected = NO;
    self.rectButton.selected = NO;
}

- (void)selectDrawingObjectType:(enum DRAWING_OBJECT_TYPE)drawingObjectType
{
    [self deselectAllDrawingObjectTypeButtons];
    
    NSArray *allButtons = @[self.freeButton,self.lineButton,self.ovalButton,self.rectButton];
    
    for (UIButton *button in allButtons) {
        if (button.tag == drawingObjectType) {
            button.selected = YES;
            break;
        }
    }
}

- (IBAction)selectDrawingObjectTypeWithButton:(UIButton *)sender
{
    [self selectDrawingObjectType:sender.tag];
    
    [ProjectSettings shared].drawObjectType = sender.tag;
    
    self.DrawingObjectTypeDidUpdate();
}

- (void)showPopoverWithCompletionHandler:(void(^)(UIColor *color))completionHandler fromRect:(CGRect)rect
{
    WeakSelf;
    PaletteViewController *palettVC = [self.storyboard instantiateViewControllerWithIdentifier:@"paletteStoryboardID"];
    palettVC.UpdateColor = ^(UIColor *color){
        if (completionHandler) {
            completionHandler(color);
        }
        [weakSelf.popover dismissPopoverAnimated:YES];
        weakSelf.popover = nil;
    };
    
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:palettVC];
    popover.delegate = self;
    popover.popoverContentSize = [PaletteViewController prefferedSize];
    
    [popover presentPopoverFromRect:self.strokeColorView.frame inView:self.view permittedArrowDirections:(UIPopoverArrowDirectionRight) animated:YES];
    
    self.popover = popover;
}


#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popover = nil;
}


@end
