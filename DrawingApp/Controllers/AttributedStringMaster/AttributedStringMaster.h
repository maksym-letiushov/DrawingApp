//
//  AttributedStringMaster.h
//  DrawingApp
//
//  Created by Maxim on 5/12/14.
//  Copyright (c) 2014 Maxim Letushov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttributedStringMaster : NSObject

+ (NSAttributedString *)normalBarButtonItemWithString:(NSString *)string;
+ (NSAttributedString *)selectedBarButtonItemWithString:(NSString *)string;

@end
