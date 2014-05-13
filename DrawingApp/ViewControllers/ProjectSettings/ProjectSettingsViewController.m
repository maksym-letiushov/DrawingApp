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

@interface ProjectSettingsViewController ()

@property (nonatomic, strong) LineWidthPickerDataSource *lineWidthPickerDataSource;

@property (weak, nonatomic) IBOutlet UIButton *freeButton;
@property (weak, nonatomic) IBOutlet UIButton *lineButton;
@property (weak, nonatomic) IBOutlet UIButton *ovalButton;
@property (weak, nonatomic) IBOutlet UIButton *rectButton;
@property (weak, nonatomic) IBOutlet UIView *strokeColorView;
@property (weak, nonatomic) IBOutlet UIView *fillColorView;
@property (weak, nonatomic) IBOutlet UIPickerView *lineWidthPickerView;

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

#pragma mark - UIPickerViewDataSource

@end
