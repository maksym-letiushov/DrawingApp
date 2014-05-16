//
//  TransformTouchesReceiverView.h
//  DrawingApp
//
//  Created by Maxim on 5/16/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransformTouchesReceiverView : UIView

@property (nonatomic, copy) void(^translate)(CGFloat tx, CGFloat ty);
@property (nonatomic, copy) void(^scale)(CGFloat scale);
@property (nonatomic, copy) void(^rotate)(CGFloat angle);
@property (nonatomic, copy) void(^transformCompletionBlock)(void);

- (instancetype)initWithFrame:(CGRect)frame
                  translation:(CGPoint)translation
                        scale:(CGFloat)scale
                        angle:(CGFloat)angle;

@end
