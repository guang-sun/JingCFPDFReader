//
//  PdfBaseViewController.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#import "PdfBookeModel.h"
#import "PdfBookMarkModel.h"
@interface PdfBaseViewController : UIViewController
@property (nonatomic,strong)NSString *navTitle;

//所有的 页面的桥都是这个
@property (nonatomic,strong)PdfBookeModel *book;
@end
