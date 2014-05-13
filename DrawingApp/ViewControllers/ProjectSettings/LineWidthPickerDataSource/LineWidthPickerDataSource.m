//
//  LineWidthPickerDataSource.m
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "LineWidthPickerDataSource.h"

@interface LineWidthPickerDataSource () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) UIPickerView *pickerView;

@end


@implementation LineWidthPickerDataSource

- (instancetype)initWithPickerView:(UIPickerView *)pickerView
{
    self = [super init];
    self.pickerView = pickerView;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    return self;
}

- (void)setLineWidth:(NSInteger)lineWidth
{
    lineWidth = MAX(MIN_LINE_WIDTH, lineWidth);
    lineWidth = MIN(MAX_LINE_WIDTH, lineWidth);
    
    [self.pickerView selectRow:lineWidth-1 inComponent:0 animated:YES];
}

- (NSInteger)lineWidth
{
    return [self.pickerView selectedRowInComponent:0]+1;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return MAX_LINE_WIDTH-MIN_LINE_WIDTH+1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", row+1];
}

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.UpdateLineWidth(self.lineWidth);
}


@end
