//
//  DrawingTouchesReceiverView.m
//  DrawingApp
//
//  Created by Maxim on 5/9/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "DrawingTouchesReceiverView.h"

@interface DrawingTouchesReceiverView ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGR;

@end

@implementation DrawingTouchesReceiverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.opaque = NO;
    self.backgroundColor = nil;
    
    self.panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    self.panGR.minimumNumberOfTouches = 1;
    self.panGR.maximumNumberOfTouches = 1;

    [self addGestureRecognizer:self.panGR];
}

- (void)pan:(UIPanGestureRecognizer *)gr
{
    BOOL isBegTouch = (gr.state == UIGestureRecognizerStateBegan);
    
    BOOL isEndTouch = (gr.state != UIGestureRecognizerStateBegan) && (gr.state != UIGestureRecognizerStateChanged);
    
    CGPoint point = [gr locationInView:self];
    
    [self.drawingGestureReceiver updateWithTouchInPoint:point isBegTouch:isBegTouch isEndTouch:isEndTouch];
}

@end
