//
//  BookListCollectionViewCell.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PdfBookeModel;
@interface BookListCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) PdfBookeModel *book;//书籍列表

@property (nonatomic,strong) UIImage *showImage;//书签列表
@property (nonatomic,strong) NSString *showName;
@end
