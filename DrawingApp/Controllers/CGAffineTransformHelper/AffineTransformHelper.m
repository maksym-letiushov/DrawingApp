//
//  AffineTransformHelper.m
//  DrawingApp
//
//  Created by Maxim on 5/16/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import "AffineTransformHelper.h"

@implementation AffineTransformHelper

+ (CGFloat)xScaleInTransform:(CGAffineTransform)transform
{
    return sqrt(transform.a * transform.a + transform.c * transform.c);
}

+ (CGFloat)yScaleInTransform:(CGAffineTransform)transform
{
    return sqrt(transform.b * transform.b + transform.d * transform.d);
}

+ (CGFloat)angleInTransform:(CGAffineTransform)transform
{
    return atan2(transform.b, transform.a);
}

+ (CGFloat)xTranslationInTransform:(CGAffineTransform)transform
{
    return transform.tx;
}

+ (CGFloat)yTranslationInTransform:(CGAffineTransform)transform
{
    return transform.ty;
}

@end
