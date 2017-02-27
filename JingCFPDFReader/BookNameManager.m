//
//  BookNameManager.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BookNameManager.h"
#import "PdfBookeModel.h"
@implementation BookNameManager
+ (NSArray *)TotalBookNames{
    return @[[self AndroidBookNames]];
}

//书籍名称
+ (NSArray *)AndroidBookNames{
    NSArray *arr = @[
                     @{@"nameString":@"第一行代码",
                       @"fileNameString":@"Android1"}
//                     ,@{@"nameString":@"",
//                        @"fileNameString":@""}
//                     ,@{@"nameString":@"",
//                        @"fileNameString":@""}
                     ];
    return [PdfBookeModel mj_objectArrayWithKeyValuesArray:arr];
}
+ (NSArray *)PHPBookNames{
    NSArray *arr = @[
                     @{@"nameString":@"第一行代码",
                       @"fileNameString":@"Android1"}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ];
    return [PdfBookeModel mj_objectArrayWithKeyValuesArray:arr];
}

+ (NSArray *)SwiftBookNames{
    NSArray *arr = @[
                     @{@"nameString":@"第一行代码",
                       @"fileNameString":@"Android1"}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ];
    return [PdfBookeModel mj_objectArrayWithKeyValuesArray:arr];
}

+ (NSArray *)ObjectCBookNames{
    NSArray *arr = @[
                     @{@"nameString":@"第一行代码",
                       @"fileNameString":@"Android1"}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ];
    return [PdfBookeModel mj_objectArrayWithKeyValuesArray:arr];
}

+ (NSArray *)HTMLBookNames{
    NSArray *arr = @[
                     @{@"nameString":@"第一行代码",
                       @"fileNameString":@"Android1"}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ];
    return [PdfBookeModel mj_objectArrayWithKeyValuesArray:arr];
}

+ (NSArray *)CssBookNames{
    NSArray *arr = @[
                     @{@"nameString":@"第一行代码",
                       @"fileNameString":@"Android1"}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ];
    return [PdfBookeModel mj_objectArrayWithKeyValuesArray:arr];
}

+ (NSArray *)JSBookNames{
    NSArray *arr = @[
                     @{@"nameString":@"第一行代码",
                       @"fileNameString":@"Android1"}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ,@{@"nameString":@"",
                        @"fileNameString":@""}
                     ];
    return [PdfBookeModel mj_objectArrayWithKeyValuesArray:arr];
}














































@end
