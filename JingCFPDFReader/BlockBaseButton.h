//
//  BlockBaseButton.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
@interface BlockBaseButton : UIButton
typedef void(^ButtonActionBlock)(BlockBaseButton *button);

- (void)addAction:(ButtonActionBlock)block;



@end
