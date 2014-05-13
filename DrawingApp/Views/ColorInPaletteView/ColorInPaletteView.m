//
//  ColorInPaletteView.m
//  DrawingApp
//
//  Created by Maxim on 5/13/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "ColorInPaletteView.h"

@interface ColorInPaletteView () <UIGestureRecognizerDelegate>

@end

@implementation ColorInPaletteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    self.opaque = NO;
    self.backgroundColor = nil;
    
    _fillColor = [UIColor clearColor];
    _strokeColor = [UIColor blackColor];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    gr.numberOfTapsRequired = 1;
    gr.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:gr];
}

- (CGFloat)radiusForRect:(CGRect)rect
{
    return MIN(rect.size.width, rect.size.height)*0.2;
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:[self radiusForRect:rect]];
    [path setLineWidth:1];
    [path addClip];

    [self.fillColor setFill];
    [self.strokeColor setStroke];
    
    [path fill];
    [path stroke];
}

- (void)tap:(UITapGestureRecognizer *)gr
{
    if (self.Tap) {
        self.Tap();
    }
}

@end
