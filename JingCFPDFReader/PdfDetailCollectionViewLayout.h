//
//  PdfDetailCollectionViewLayout.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfDetailCollectionViewLayout : UICollectionViewLayout
@property(nonatomic, strong)NSMutableArray* cellLayoutList;
@property (nonatomic,assign) float leftCellWidth;//距离左右距离

@end
