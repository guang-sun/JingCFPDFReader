

//
//  PdfDetailCollectionViewLayout.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PdfDetailCollectionViewLayout.h"

@implementation PdfDetailCollectionViewLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (void)prepareLayout
{
    [super prepareLayout];
    [self.cellLayoutList removeAllObjects];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    for (int i=0; i<self.collectionView.numberOfSections; i++) {
        for (int j=0; j<[self.collectionView numberOfItemsInSection:i]; j++) {
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
            [self.cellLayoutList addObject:attrs];
        }
    }
}
/**
 * 返回collectionView的contentSize，来决定collectionView的滚动范围
 */
- (CGSize)collectionViewContentSize
{
    NSInteger row = [self.collectionView numberOfItemsInSection:0];
    float width = self.collectionView.frame.size.width * row;
    return CGSizeMake(width,self.collectionView.bounds.size.height);
}

- (CGPoint) targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    return  proposedContentOffset;
}
/**
 * Returns the layout attributes for all of the cells and views in the specified rectangle.
 * cell 滚动时调用
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes* attribute in self.cellLayoutList) {
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            [array addObject:attribute];
        }
    }
    return array;
}

-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    float ory = indexPath.row * self.collectionView.frame.size.width;
    //创建布局实例
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(ory+self.leftCellWidth, 0, self.collectionView.frame.size.width-self.leftCellWidth*2, self.collectionView.bounds.size.height);
    //缩放
    CGFloat centerX = self.collectionView.frame.size.width / 2 + self.collectionView.contentOffset.x;
    CGFloat space = ABS(attributes.center.x - centerX);
    CGFloat scale = 1 - (space/self.collectionView.frame.size.width/5);
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    //设置布局属性
    attributes.zIndex = index;
    
    return attributes;
}


//get
- (NSMutableArray *)cellLayoutList{
    if (!_cellLayoutList) {
        _cellLayoutList = [NSMutableArray array];
    }
    return _cellLayoutList;
}
@end
