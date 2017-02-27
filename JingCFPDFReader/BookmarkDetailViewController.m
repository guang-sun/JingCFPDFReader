
//
//  BookmarkDetailViewController.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BookmarkDetailViewController.h"
#import "PdfImageManager.h"
#import "PDFSaveManager.h"

#import "PdfDetailCollectionViewLayout.h"
#import "BookDetailCollectionViewCell.h"
@interface BookmarkDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)PdfDetailCollectionViewLayout *collectionLayout;
@property (nonatomic,strong)PdfImageManager *pdfAdapterManager;
@property (nonatomic,strong)PDFSaveManager *pdfSaveManager;
@property (nonatomic,strong)UIImageView *currentImageView;
@property (nonatomic,strong)NSMutableArray *bookMarksArray;
@end

@implementation BookmarkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"书签详情";
    [self.view addSubview:self.collectionView];
    
    [self goCurrentBookMark];
    // Do any additional setup after loading the view.
}
#pragma mark 辅助方法
- (void)goCurrentBookMark{
    NSInteger currentPage = 0;
    for (PdfBookMarkModel *bookMark in self.bookMarksArray) {
        if (bookMark.pageNumber.integerValue == self.bookMark.pageNumber.integerValue) {
            currentPage = [self.bookMarksArray indexOfObject:bookMark];
            break;
        }
    }
    NSIndexPath *index = [NSIndexPath indexPathForItem:currentPage inSection:0];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
#pragma mark collectionDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.width;
    PdfBookMarkModel *bookMark = self.bookMarksArray[currentPage];//当前的bookmark;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.bookMarksArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PdfBookMarkModel *bookMark = self.bookMarksArray[indexPath.row];//当前的bookmark;

    BookDetailCollectionViewCell* cell = (BookDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BookDetailCollectionViewCell" forIndexPath:indexPath];
    cell.showImageView.image = [self.pdfAdapterManager pdfImageByIndex:bookMark.pageNumber.integerValue];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //出现工具栏？
    
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , self.view.screenWidth, self.view.screenHeight-64) collectionViewLayout:self.collectionLayout];
        [_collectionView registerClass:[BookDetailCollectionViewCell class] forCellWithReuseIdentifier:@"BookDetailCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (PdfDetailCollectionViewLayout *)collectionLayout{
    if (!_collectionLayout) {
        _collectionLayout = [[PdfDetailCollectionViewLayout alloc] init];
    }
    return _collectionLayout;
}

- (PdfImageManager *)pdfAdapterManager{
    if (!_pdfAdapterManager) {
        _pdfAdapterManager = [[PdfImageManager alloc] initWithLocationFileName:self.book.fileNameString];
    }
    return _pdfAdapterManager;
}

- (PDFSaveManager *)pdfSaveManager{
    if (!_pdfSaveManager) {
        _pdfSaveManager = [[PDFSaveManager alloc] initWithBook:self.book];
    }
    return _pdfSaveManager;
}

- (NSMutableArray *)bookMarksArray{
    if (!_bookMarksArray) {
        NSArray *bookMarks = [PdfSortingManager PdfBookmarkSortingWithArray:[self.pdfSaveManager allBookmarks]];

        _bookMarksArray = [NSMutableArray arrayWithArray:bookMarks];
    }
    return _bookMarksArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
