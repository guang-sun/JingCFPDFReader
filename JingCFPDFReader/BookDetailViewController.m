//
//  BookDetailViewController.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookMarksViewController.h"
#import "PdfDetailCollectionViewLayout.h"
#import "BookDetailCollectionViewCell.h"
#import "PdfImageManager.h"
#import "PDFSaveManager.h"

@interface BookDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)PdfDetailCollectionViewLayout *collectionLayout;
@property (nonatomic,strong)PdfImageManager *pdfAdapterManager;
@property (nonatomic,strong)PDFSaveManager *pdfSaveManager;
@property (nonatomic,strong)UIImageView *currentImageView;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,strong)UIBarButtonItem *addBookMarkButton;
//@property (nonatomic,strong)
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [NSString stringWithFormat:@"阅读%@",self.book.nameString];
    self.navigationItem.rightBarButtonItems = [self createdRightBarButtonItems];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
    [self goBeforeReadPlace];
    
}

- (void)goBeforeReadPlace{
    NSInteger currentPage = [self.pdfSaveManager currentPage];
    [self isAddBookMark:currentPage];
    self.currentIndex = currentPage-1;
    NSIndexPath *index = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
#pragma mark 辅助方法
- (UIBarButtonItem *)buttonIteamWithNorMorImageString:(NSString *)normalImageString AndSelectImageString:(NSString *)selectImageString AndAction:(ButtonActionBlock)block{
    BlockBaseButton *button = [[BlockBaseButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (normalImageString) {
        [button setImage:[UIImage imageNamed:normalImageString] forState:UIControlStateNormal];
    }
    if (selectImageString) {
        [button setImage:[UIImage imageNamed:selectImageString] forState:UIControlStateSelected];
    }
    [button addAction:block];
    UIBarButtonItem *iteam = [[UIBarButtonItem alloc] initWithCustomView:button];
    return iteam;
}
- (void)isAddBookMark:(NSInteger)page{
   ((UIButton *)self.addBookMarkButton.customView).selected = [self.pdfSaveManager isSaveBookmarkWithCurrentPage:page];
}
//BookMarks
//Reader-Mark-N
//Reader-Mark-Y
- (NSArray *)createdRightBarButtonItems{
    @WeakObj(self);
    self.addBookMarkButton = [self buttonIteamWithNorMorImageString:@"Reader-Mark-N" AndSelectImageString:@"Reader-Mark-Y" AndAction:^(BlockBaseButton *button) {
        [selfWeak saveBookMarkWithPage:selfWeak.currentIndex+1 AndIntroduction:@"ssss" AndIsRem:button.selected];
        button.selected = !button.selected;
    }];
    UIBarButtonItem *bookMarkButtonList = [self buttonIteamWithNorMorImageString:@"BookMarks" AndSelectImageString:nil AndAction:^(BlockBaseButton *button) {
        BookMarksViewController *bookmarks = [[BookMarksViewController alloc] init];
        bookmarks.book = selfWeak.book;
        [selfWeak.navigationController pushViewController:bookmarks animated:YES ];
    }];
    return @[self.addBookMarkButton,bookMarkButtonList];
}
- (void)saveBookMarkWithPage:(NSInteger)page AndIntroduction:(NSString *)introduction AndIsRem:(BOOL)isRemove{
    PdfBookMarkModel *bookMark = [PdfBookMarkModel mj_objectWithKeyValues:@{
                                                                            @"pageNumber":@(page),
                                                                            @"introduction":introduction
                                                                            }];
    if (isRemove) {
        [self.pdfSaveManager removeBookmarksWithBookMark:bookMark];
    }else{
        [self.pdfSaveManager savaBookmarksWithBookMark:bookMark];
    }
}
#pragma mark collectionDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.width;
    //存储 当前看到第几页
    [self.pdfSaveManager savePageCurrentPage:currentPage+1];
    //存储书签的时候用
    self.currentIndex = currentPage;
    //是否已经添加
    [self isAddBookMark:currentPage+1];
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
#pragma mark tap
//    [self addAllGesture];
//-(void)addAllGesture
//{
//    //捏合手势
//    UIPinchGestureRecognizer * pinGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinGesture:)];
//    [self.view addGestureRecognizer:pinGesture];
//    //拖动手势
//    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
//    [self.view addGestureRecognizer:panGesture];
//}
//-(void)handlePinGesture:(UIPinchGestureRecognizer *)pinGesture
//{
//    UIView * view = self.currentImageView;
//    if(pinGesture.state == UIGestureRecognizerStateBegan || pinGesture.state == UIGestureRecognizerStateChanged)
//    {
//        view.transform = CGAffineTransformScale(_imageViewScale.transform, pinGesture.scale,pinGesture.scale);
//        pinGesture.scale = 1.0;
//    }
//    else if(pinGesture.state == UIGestureRecognizerStateEnded)
//    {
//        lastScale = 1.0;
//        CGFloat ration =  view.frame.size.width /self.OriginalFrame.size.width;
//        if(ration>_scaleRation) // 缩放倍数 > 自定义的最大倍数
//        {
//            CGRect newFrame =CGRectMake(0, 0, self.OriginalFrame.size.width * _scaleRation, self.OriginalFrame.size.height * _scaleRation);
//            view.frame = newFrame;
//        }else if (self.isHorizontalChart&&view.frame.size.height< self.OriginalFrame.size.height){//横图 且 当前的height < OriginalFrame.height
//            view.frame = self.OriginalFrame;
//
//        }else if(!self.isHorizontalChart&&view.frame.size.width< self.OriginalFrame.size.width){//竖图 且 当前的width < OriginalFrame.width
//            view.frame = self.OriginalFrame;
//        }
//        //        else if (view.frame.size.width < self.circularFrame.size.width && self.OriginalFrame.size.width <= self.OriginalFrame.size.height)
//        //        { //横图
//        //            view.frame = [self handelWidthLessHeight:view];
//        //            view.frame = [self handleScale:view];
//        //        }
//        //        else if(view.frame.size.height< self.circularFrame.size.height && self.OriginalFrame.size.height <= self.OriginalFrame.size.width)
//        //        { //竖图
//        //            view.frame =[self handleHeightLessWidth:view];
//        //            view.frame = [self handleScale:view];
//        //        }
//        else
//        {
//            view.frame = [self handleScale:view];
//        }
//        self.currentFrame = view.frame;
//    }
//}

//-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
//{
//    UIView * view = _imageView;
//
//    if(panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged)
//    {
//        CGPoint translation = [panGesture translationInView:view.superview];
//        [view setCenter:CGPointMake(view.center.x + translation.x, view.center.y + translation.y)];
//
//        [panGesture setTranslation:CGPointZero inView:view.superview];
//    }
//    else if ( panGesture.state == UIGestureRecognizerStateEnded)
//    {
//        CGRect currentFrame = view.frame;
//        //向右滑动 并且超出裁剪范围后
//        if(currentFrame.origin.x >= self.circularFrame.origin.x)
//        {
//            currentFrame.origin.x =self.circularFrame.origin.x;
//        }
//        //向下滑动 并且超出裁剪范围后
//        if(currentFrame.origin.y >= self.circularFrame.origin.y)
//        {
//            currentFrame.origin.y = self.circularFrame.origin.y;
//        }
//        //向左滑动 并且超出裁剪范围后
//        if(currentFrame.size.width + currentFrame.origin.x < self.circularFrame.origin.x + self.circularFrame.size.width)
//        {
//            CGFloat movedLeftX =fabs(currentFrame.size.width + currentFrame.origin.x -(self.circularFrame.origin.x + self.circularFrame.size.width));
//            currentFrame.origin.x += movedLeftX;
//        }
//        //向上滑动 并且超出裁剪范围后
//        if(currentFrame.size.height+currentFrame.origin.y < self.circularFrame.origin.y + self.circularFrame.size.height)
//        {
//            CGFloat moveUpY =fabs(currentFrame.size.height + currentFrame.origin.y -(self.circularFrame.origin.y + self.circularFrame.size.height));
//            currentFrame.origin.y += moveUpY;
//        }
//        [UIView animateWithDuration:0.05 animations:^{
//            [view setFrame:currentFrame];
//        }];
//    }
//}
