//
//  LineWidthPickerDataSource.h
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LineWidthPickerDataSource : NSObject

@property (nonatomic, assign) NSInteger lineWidth;
@property (nonatomic, copy) void(^UpdateLineWidth)(NSInteger lineWidth);

- (instancetype)initWithPickerView:(UIPickerView *)pickerView;


@end
