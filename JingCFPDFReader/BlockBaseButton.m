
//
//  BlockBaseButton.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BlockBaseButton.h"
@interface BlockBaseButton ()
@property (nonatomic,copy)ButtonActionBlock block;


@end
@implementation BlockBaseButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //统一的设置
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}



- (void)addAction:(ButtonActionBlock)block{
    self.block = block;
}

-(void)buttonAction:(BlockBaseButton *)button{
    if (self.block) {//block 里有耗时操作时防止连续点击
        button.userInteractionEnabled = NO;
        self.block(button);
        button.userInteractionEnabled = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
