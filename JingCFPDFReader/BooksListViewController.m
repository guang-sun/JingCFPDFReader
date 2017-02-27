
//
//  BooksListViewController.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "BooksListViewController.h"
#import "BookDetailViewController.h"
#import "BookListCollectionViewCell.h"
#import "BookNameManager.h"
@interface BooksListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *contensArray;

@end

@implementation BooksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书库";
    // Do any additional setup after loading the view.
}
#pragma  mark collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.contensArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray *)self.contensArray[section]).count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(0,0);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
//    return (SCREEN_WIDTH - HomePage_Iteam_HeadImage_size*3)/4-1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
//    return HomePage_Iteam_buttomOry;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookListCollectionViewCell *cell = (BookListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BookListCollectionViewCell" forIndexPath:indexPath];
    PdfBookeModel *book = self.contensArray[indexPath.section][indexPath.item];
//    KapModelPeople *userModel = self.contensArray[indexPath.item];
//    cell.userModel = userModel;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PdfBookeModel *book = self.contensArray[indexPath.section][indexPath.item];
    [self pushBookDetailConWithBook:book];
}
#pragma mark push
- (void)pushBookDetailConWithBook:(PdfBookeModel *)book{
    BookDetailViewController *con = [[BookDetailViewController alloc] init];
    con.book = book;
    [self.navigationController pushViewController:con animated:YES];
}
#pragma mark get
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        float orx = 0;
        float ory = 0;
        float width = self.view.screenWidth;
        float height = self.view.screenHeight-self.view.navHeight;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(orx, ory, width, height) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[BookListCollectionViewCell class] forCellWithReuseIdentifier:@"BookListCollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
- (NSMutableArray *)contensArray{
    if (!_contensArray) {
        _contensArray = [NSMutableArray arrayWithArray:[BookNameManager TotalBookNames]];
    }
    return _contensArray;
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
