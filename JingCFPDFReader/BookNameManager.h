//
//  BookNameManager.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookNameManager : NSObject
+ (NSArray *)TotalBookNames;

//书籍名称
+ (NSArray *)AndroidBookNames;
+ (NSArray *)PHPBookNames;
+ (NSArray *)SwiftBookNames;
+ (NSArray *)ObjectCBookNames;
+ (NSArray *)HTMLBookNames;
+ (NSArray *)CssBookNames;
+ (NSArray *)JSBookNames;
@end
