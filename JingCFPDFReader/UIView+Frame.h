//
//  UIView+Frame.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat  originX;
@property (nonatomic, assign) CGFloat  originY;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

@property (nonatomic, assign) CGFloat  centerX;
@property (nonatomic, assign) CGFloat  centerY;

//readOnly
@property (nonatomic,readonly)CGFloat screenWidth;
@property (nonatomic,readonly)CGFloat screenHeight;
@property (nonatomic,readonly)CGFloat navHeight;
@end
