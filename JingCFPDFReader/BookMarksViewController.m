//
//  BookMarksViewController.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BookMarksViewController.h"
#import "PdfBookMarkModel.h"
#import "BookListCollectionViewCell.h"
#import "BookmarkDetailViewController.h"
#import "PdfImageManager.h"
#import "PDFSaveManager.h"

#define  CFList_count    3
#define  CFBook_margin   10.0f

@interface BookMarksViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)PdfImageManager *pdfAdapterManager;
@property (nonatomic,strong)PDFSaveManager *pdfSaveManager;

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *contensArray;

@end

@implementation BookMarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"书签目录";
    [self.view addSubview:self.collectionView];

    // Do any additional setup after loading the view.
}

#pragma  mark collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contensArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PdfBookMarkModel *bookMark = self.contensArray[indexPath.item];
    BookListCollectionViewCell *cell = (BookListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BookListCollectionViewCell" forIndexPath:indexPath];
    cell.showImage = [self.pdfAdapterManager pdfImageByIndex:bookMark.pageNumber.integerValue];
    cell.showName = bookMark.introduction;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PdfBookMarkModel *bookMark = self.contensArray[indexPath.item];
    [self pushBookmarkDetailConWithBook:bookMark];
}
#pragma mark push
- (void)pushBookmarkDetailConWithBook:(PdfBookMarkModel *)bookMark{
    BookmarkDetailViewController *con = [[BookmarkDetailViewController alloc] init];
    con.book = self.book;
    con.bookMark = bookMark;
    [self.navigationController pushViewController:con animated:YES];
}
#pragma mark get
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        float orx = 0;
        float ory = 0;
        float width = self.view.screenWidth;
        float height = self.view.screenHeight-self.view.navHeight;
        float  item_width = (width - CFBook_margin * ((CFList_count -1)*2 +2))/ CFList_count;
        float  item_height = item_width / 3 * 4 +20;
        
        UICollectionViewFlowLayout *layout =  [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(item_width , item_height );
        layout.minimumLineSpacing = CFBook_margin;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(CFBook_margin, CFBook_margin, CFBook_margin, CFBook_margin);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(orx, ory, width , height) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor brownColor];
        [_collectionView registerClass:[BookListCollectionViewCell class] forCellWithReuseIdentifier:@"BookListCollectionViewCell"];
    }
    return _collectionView;
}
- (NSMutableArray *)contensArray{
    if (!_contensArray) {
       NSArray *bookMarks = [PdfSortingManager PdfBookmarkSortingWithArray:[self.pdfSaveManager allBookmarks]];
        _contensArray = [NSMutableArray arrayWithArray:bookMarks];
    }
    return _contensArray;
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
