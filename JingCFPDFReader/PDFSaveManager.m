//
//  PDFSaveManager.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PDFSaveManager.h"
#import "PdfBookMarkModel.h"
#import "PdfBookeModel.h"
@interface PDFSaveManager ()
@property (nonatomic,strong)NSString *fileName;
@property (nonatomic,strong)NSString *bookName;

@property (nonatomic,strong)NSMutableArray *bookMarksArray;
@property (nonatomic,strong)NSMutableArray *bookMarksPageArray;

@end
@implementation PDFSaveManager
- (instancetype)initWithBook:(PdfBookeModel *)book{
    self = [super init];
    if (self) {
        self.fileName = book.fileNameString;
        self.bookName = book.nameString;
        [PDFSaveManager SaveReadBook:book];
    }
    return self;
}

//自动保存进度
- (NSString *)saveKey{
    return [NSString stringWithFormat:@"%@Save",self.fileName];
}
- (void)savePageCurrentPage:(NSInteger)currentPage{
    [PDFSaveManager savePageWithName:self.saveKey AndCurrentPage:currentPage];
}
- (NSInteger)currentPage{
    return [PDFSaveManager currentPageWithName:self.saveKey];
}

//书签
- (NSString *)saveBookmarkKey{
    return [NSString stringWithFormat:@"%@Bookmark",self.fileName];
}
- (BOOL)isSaveBookmarkWithCurrentPage:(NSInteger)currentPage{
    if (<#condition#>) {
        <#statements#>
    }
    return [self.bookMarksPageArray containsObject:@(currentPage)];
}
- (void)savaBookmarksWithBookMark:(PdfBookMarkModel *)model{
    [self bookMarksArrayAddWithIsRemove:NO AndBookMark:model];
    [PDFSaveManager savaBookmarksWithName:self.saveBookmarkKey AndBookmarks:self.bookMarksArray];
}
- (NSArray<PdfBookMarkModel *> *)allBookmarks{
    return self.bookMarksArray;
}
- (void)removeBookmarksWithBookMark:(PdfBookMarkModel *)model{
    [self bookMarksArrayAddWithIsRemove:YES AndBookMark:model];
    [PDFSaveManager savaBookmarksWithName:self.saveBookmarkKey AndBookmarks:self.bookMarksArray];

}
- (void)bookMarksArrayAddWithIsRemove:(BOOL)remove AndBookMark:(PdfBookMarkModel *)model{
    if (remove) {
        NSInteger index = [self.bookMarksPageArray indexOfObject:model.pageNumber];
        if (index != NSNotFound) {
            [self.bookMarksArray removeObjectAtIndex:index];
            [self.bookMarksPageArray removeObjectAtIndex:index];
        }
    }else{
        [self.bookMarksArray addObject:model];
        [self.bookMarksPageArray addObject:model.pageNumber];
    }
}
#pragma  mark get
- (void)createrArray{
    _bookMarksArray = [NSMutableArray array];
    _bookMarksPageArray = [NSMutableArray array];
    NSArray *array = [PDFSaveManager allBookmarksWithName:self.saveBookmarkKey];
    for (PdfBookMarkModel *bookMark in array) {
        [_bookMarksArray addObject:bookMark];
        [_bookMarksPageArray addObject:bookMark.pageNumber];
    }
}
- (NSMutableArray *)bookMarksArray{
    if (!_bookMarksArray) {
        [self createrArray];
    }
    return _bookMarksArray;
}
- (NSMutableArray *)bookMarksPageArray{
    if (!_bookMarksPageArray) {
        [self createrArray];
    }
    return _bookMarksPageArray;
}
#pragma  mark 静态方法
// 保存最后阅读的书籍
+ (NSString *)BookNameKey{
    return @"KEY_BOOK_SAVE_KEY";
}
+ (void)SaveReadBook:(PdfBookeModel *)book{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:book];
    [self UserDefaultsSaveOBJ:data ForKey:[self BookNameKey]];
}
+ (PdfBookeModel *)LastReadBookName{
    NSData *data =  [self UserDefaultsObjForKey:[self BookNameKey]];
    PdfBookeModel *book = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return book;
}

+ (void)savePageWithName:(NSString *)name AndCurrentPage:(NSInteger)currentPage{
    [self UserDefaultsSaveOBJ:@(currentPage) ForKey:name];
}

+ (NSInteger)currentPageWithName:(NSString *)name{
    NSNumber *num = [self UserDefaultsObjForKey:name];
    if (!num) {
        num = @(1);
        [self savePageWithName:name AndCurrentPage:1];
    }
    return num.integerValue;
}


+ (void)savaBookmarksWithName:(NSString *)name AndBookmarks:(NSArray *)bookmarksArray{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:bookmarksArray];
    [self UserDefaultsSaveOBJ:data ForKey:name];
}
+ (NSArray *)allBookmarksWithName:(NSString *)name{
    NSData *data = [self UserDefaultsObjForKey:name];
    NSArray *bookmarksArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return bookmarksArray;
}

//save
+ (void)UserDefaultsSaveOBJ:(id)obj ForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (id)UserDefaultsObjForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}



@end
