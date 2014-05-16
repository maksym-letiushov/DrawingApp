//
//  AffineTransformHelper.h
//  DrawingApp
//
//  Created by Maxim on 5/16/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AffineTransformHelper : NSObject

+ (CGFloat)xScaleInTransform:(CGAffineTransform)transform;
+ (CGFloat)yScaleInTransform:(CGAffineTransform)transform;
+ (CGFloat)angleInTransform:(CGAffineTransform)transform;
+ (CGFloat)xTranslationInTransform:(CGAffineTransform)transform;
+ (CGFloat)yTranslationInTransform:(CGAffineTransform)transform;

@end
