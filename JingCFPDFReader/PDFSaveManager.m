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
- (void)savaBookmarksWithBookMark:(PdfBookMarkModel *)model{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self allBookmarks]];
    [array addObject:model];
    [PDFSaveManager savaBookmarksWithName:self.saveBookmarkKey AndBookmarks:array];
}
- (NSArray<PdfBookMarkModel *> *)allBookmarks{
    return [PDFSaveManager allBookmarksWithName:self.saveBookmarkKey];
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
