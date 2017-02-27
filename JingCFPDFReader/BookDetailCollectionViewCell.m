

//
//  BookDetailCollectionViewCell.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BookDetailCollectionViewCell.h"

@implementation BookDetailCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.showImageView];
    }
    return self;
}
-(void)layoutSubviews{
    self.showImageView.frame = self.contentView.bounds;
}

-(UIImageView *)showImageView{
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] init];
        _showImageView.contentMode = UIViewContentModeScaleAspectFit;
        _showImageView.backgroundColor = [UIColor redColor];
    }
    return _showImageView;
}
@end
