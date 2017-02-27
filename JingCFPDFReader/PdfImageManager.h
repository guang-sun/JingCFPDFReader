//
//  PdfImageManager.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
//解析pdf的类
@interface PdfImageManager : NSObject
- (instancetype)initWithLocationFileName:(NSString *)fileName;
- (instancetype)initWithFileURLString:(NSString *)fileURLString;
- (UIImage *)pdfFirstImage;
- (UIImage *)pdfImageByIndex:(NSInteger)index;
- (NSInteger)pdfTotlaCount;
/**
 * 获取所有的 image 耗时实在是太久了 用上边那几个 函数 分布加载吧
 */
- (NSArray *)pdfImageArray;
@end
