
//
//  PdfSortingManager.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PdfSortingManager.h"
#import "PdfBookMarkModel.h"
@implementation PdfSortingManager
+ (NSArray *)PdfBookmarkSortingWithArray:(NSArray *)bookMarkArray{
    NSArray *sourtingResultArray =
    [bookMarkArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (((PdfBookMarkModel *)obj1).pageNumber.integerValue > ((PdfBookMarkModel *)obj2).pageNumber.integerValue);
    }];
    return sourtingResultArray;
}

@end
