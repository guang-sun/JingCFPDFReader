//
//  PdfBookeModel.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BaseModel.h"

@interface PdfBookeModel : BaseModel<NSCoding>
@property (nonatomic,strong) NSString *nameString;
@property (nonatomic,strong) NSString *fileNameString;

@end
