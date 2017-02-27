
//
//  UIColor+JING.m
//  KapEp
//
//  Created by jing on 16/12/5.
//  Copyright © 2016年 jing. All rights reserved.
//

#import "UIColor+JING.h"

@implementation UIColor (JING)
- (UIImage *)backgroundImage{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
