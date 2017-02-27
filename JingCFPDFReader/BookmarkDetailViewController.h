//
//  BookmarkDetailViewController.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PdfBaseViewController.h"

@interface BookmarkDetailViewController : PdfBaseViewController
//书签详情(点击的哪个书签)
@property (nonatomic,strong)PdfBookMarkModel *bookMark;
@end
