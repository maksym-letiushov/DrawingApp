//
//  DrawingGestureReceiver.h
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DrawingGestureReceiver <NSObject>

- (void)updateWithTouchInPoint:(CGPoint) point isBegTouch:(BOOL)isBegTouch isEndTouch:(BOOL)isEndTouch;

@end
