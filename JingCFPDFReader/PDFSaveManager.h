//
//  PDFSaveManager.h
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PdfBookMarkModel;
@class PdfBookeModel;

@interface PDFSaveManager : NSObject
/**
 * LastReadBookName 最后阅读的书籍
 * initWithBookName 存储最后阅读的书籍名称
 */
+ (PdfBookeModel *)LastReadBookName;

- (instancetype)initWithBook:(PdfBookeModel *)book;
//退出时保存进度
- (void)savePageCurrentPage:(NSInteger)currentPage;
- (NSInteger)currentPage;

//书签
- (BOOL)isSaveBookmarkWithCurrentPage:(NSInteger)currentPage;
- (void)savaBookmarksWithBookMark:(PdfBookMarkModel *)model;
- (NSArray<PdfBookMarkModel *> *)allBookmarks;
- (void)removeBookmarksWithBookMark:(PdfBookMarkModel *)model;
@end
