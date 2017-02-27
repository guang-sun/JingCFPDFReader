
//
//  PdfSortingManager.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PdfSortingManager.h"

@implementation PdfSortingManager
+ (NSArray *)PdfBookmarkSortingWithArray:(NSArray *)bookMarkArray{
    NSArray *sourtingResultArray =
    [bookMarkArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (((NSNumber *)obj1).integerValue > ((NSNumber *)obj2).integerValue);
    }];
    return sourtingResultArray;
}

@end
