
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


#define  CFList_count    3
#define  CFBook_margin   10.0f

@interface BooksListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *contensArray;

@end

@implementation BooksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书库";
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}
#pragma  mark collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.contensArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((NSArray *)self.contensArray[section]).count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookListCollectionViewCell *cell = (BookListCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BookListCollectionViewCell" forIndexPath:indexPath];
    PdfBookeModel *book = self.contensArray[indexPath.section][indexPath.item];
    cell.book = book;
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
        //        _collectionView.backgroundColor = [UIColor whiteColor];
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
