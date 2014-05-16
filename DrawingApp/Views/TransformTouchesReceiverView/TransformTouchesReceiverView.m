//
//  TransformTouchesReceiverView.m
//  DrawingApp
//
//  Created by Maxim on 5/16/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "TransformTouchesReceiverView.h"
#import "AffineTransformHelper.h"

@interface TransformTouchesReceiverView () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIPanGestureRecognizer *panGR;
@property (nonatomic, weak) UIPinchGestureRecognizer *pinchGR;
@property (nonatomic, weak) UIRotationGestureRecognizer *rotationGR;

@end

@implementation TransformTouchesReceiverView

- (instancetype)initWithFrame:(CGRect)frame
                  translation:(CGPoint)translation
                        scale:(CGFloat)scale
                        angle:(CGFloat)angle
{
    self = [super initWithFrame:frame];
    
    self.opaque = NO;
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    self.userInteractionEnabled = YES;
    
    CGAffineTransform transform = self.transform;
    transform = CGAffineTransformTranslate(transform, translation.x, translation.y);
    transform = CGAffineTransformScale(transform, scale, scale);
    transform = CGAffineTransformRotate(transform, angle);
    self.transform = transform;
    
    [self setupGestureRecognizers];
    
    return self;
}

- (void)setupGestureRecognizers
{
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [panGR setTranslation:CGPointZero inView:self];
    
    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinchGR.scale = 1.0;
    
    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    rotationGR.rotation = 0.0;
    
    panGR.delegate = self;
    pinchGR.delegate = self;
    rotationGR.delegate = self;
    
    [self addGestureRecognizer:panGR];
    [self addGestureRecognizer:pinchGR];
    [self addGestureRecognizer:rotationGR];
    
    self.panGR = panGR;
    self.pinchGR = pinchGR;
    self.rotationGR = rotationGR;
}

- (void)pan:(UIPanGestureRecognizer *)gr
{
    CGPoint translation = [gr translationInView:self];
    
    self.transform = CGAffineTransformTranslate(self.transform, translation.x, translation.y);
    
    [gr setTranslation:CGPointZero inView:self];
    
    if (self.translate) {
        self.translate([AffineTransformHelper xTranslationInTransform:self.transform],[AffineTransformHelper yTranslationInTransform:self.transform]);
    }
    
    [self handleGestureRecognizerState:gr.state];
    
//    NSLog(@"dx = %f dy = %f",self.transform.tx, self.transform.ty);
}

- (void)pinch:(UIPinchGestureRecognizer *)gr
{
    CGFloat scale = gr.scale;
    self.transform = CGAffineTransformScale(self.transform, scale, scale);
    
    gr.scale = 1.0;
    
    if (self.scale) {
        self.scale([AffineTransformHelper xScaleInTransform:self.transform]);
    }
    
    [self handleGestureRecognizerState:gr.state];
    
//    NSLog(@"scale = %f grScale=%f",scale,gr.scale);
}

- (void)rotate:(UIRotationGestureRecognizer *)gr
{
    CGFloat angle = gr.rotation;
    self.transform = CGAffineTransformRotate(self.transform, angle);
    
    gr.rotation = 0.0;
    
    if (self.rotate) {
        self.rotate([AffineTransformHelper angleInTransform:self.transform]);
    }
    
    [self handleGestureRecognizerState:gr.state];
    
//    NSLog(@"angle=%f",angle);
}

- (void)handleGestureRecognizerState:(UIGestureRecognizerState)state
{
    if (state == UIGestureRecognizerStateEnded ||
        state == UIGestureRecognizerStateCancelled ||
        state ==UIGestureRecognizerStateFailed) {

        if (self.transformCompletionBlock) {
            self.transformCompletionBlock();
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
