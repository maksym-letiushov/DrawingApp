//
//  DrawingTouchesReceiverView.h
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingGestureReceiver.h"

@interface DrawingTouchesReceiverView : UIView

@property (nonatomic, weak) id<DrawingGestureReceiver> drawingGestureReceiver;

@end
