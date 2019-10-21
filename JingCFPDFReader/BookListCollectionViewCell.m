
//
//  BookListCollectionViewCell.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BookListCollectionViewCell.h"
#import "PdfImageManager.h"
#import "PdfBookeModel.h"
@interface BookListCollectionViewCell ()

@property (nonatomic,strong) UIImageView *showImageView;
@property (nonatomic,strong) UILabel     *nameLable;

@end
@implementation BookListCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.showImageView];
        [self addSubview:self.nameLable];
    }
    return self;
}
-(void)layoutSubviews{
    self.showImageView.frame = CGRectMake(0, 0 , self.frame.size.width, self.frame.size.height - 20);
    self.nameLable.frame = CGRectMake(0, CGRectGetMaxY(self.showImageView.frame),  self.frame.size.width,  20);
}

-(UIImageView *)showImageView{
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] init];
        _showImageView.contentMode = UIViewContentModeScaleAspectFit;
        _showImageView.backgroundColor = [UIColor whiteColor];
    }
    return _showImageView;
}

-(UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]init];
        _nameLable.textAlignment = NSTextAlignmentCenter;
        //        _nameLable
    }
    return _nameLable;
}

- (void)setBook:(PdfBookeModel *)book{
    _book = book;
    self.showName = book.nameString;
    PdfImageManager *imageManager = [[PdfImageManager alloc]initWithLocationFileName:book.fileNameString];
    self.showImage = [imageManager  pdfFirstImage];
}
- (void)setShowName:(NSString *)showName{
    _showName = showName;
    self.nameLable.text = showName;
}
-(void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    self.showImageView.image = showImage;
}
@end
