//
//  PdfBookMarkModel.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BaseModel.h"
//书签对象
@interface PdfBookMarkModel : BaseModel <NSCoding>
@property (nonatomic,strong)NSNumber *pageNumber;
@property (nonatomic,strong)NSString *introduction;
@end
