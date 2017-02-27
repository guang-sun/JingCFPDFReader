//
//  PdfSortingManager.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PdfSortingManager : NSObject
+ (NSArray *)PdfBookmarkSortingWithArray:(NSArray *)bookMarkArray;
@end
