//
//  BookDetailViewController.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BookDetailViewController.h"
#import "PDFSaveManager.h"
#import "PdfBookeModel.h"
#import "PdfDetailCollectionViewLayout.h"
#import "BookDetailCollectionViewCell.h"
#import "PdfImageManager.h"
@interface BookDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)PdfDetailCollectionViewLayout *collectionLayout;
@property (nonatomic,strong)PdfImageManager *pdfAdapterManager;
@property (nonatomic,strong)PDFSaveManager *pdfSaveManager;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [NSString stringWithFormat:@"阅读%@",self.book.nameString];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
    [self goBeforeReadPlace];
}
- (void)goBeforeReadPlace{
    NSInteger currentPage = [self.pdfSaveManager currentPage];
    NSIndexPath *index = [NSIndexPath indexPathForItem:currentPage-1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
#pragma mark collectionDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.width;
    //存储 当前看到第几页
    [self.pdfSaveManager savePageCurrentPage:currentPage+1];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.pdfAdapterManager pdfTotlaCount];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookDetailCollectionViewCell* cell = (BookDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BookDetailCollectionViewCell" forIndexPath:indexPath];
    cell.showImageView.image = [self.pdfAdapterManager pdfImageByIndex:indexPath.item+1];
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
        _collectionView.backgroundColor = [UIColor whiteColor];
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
