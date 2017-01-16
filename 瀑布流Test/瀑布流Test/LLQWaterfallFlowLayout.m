//
//  LLQWaterfallFlowLayout.m
//  瀑布流Test
//
//  Created by LLQ on 17/1/1.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import "LLQWaterfallFlowLayout.h"

@interface LLQWaterfallFlowLayout ()
{
    int _maxHeight; //记录最高列高度
}
@property (nonatomic, strong)NSMutableArray *attributesArray;

@end

@implementation LLQWaterfallFlowLayout

//lazy
- (NSMutableArray *)attributesArray{
    if (_attributesArray == nil) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}

////当collectionView的frame有新改变(发生移动)时调用，其若返回YES则重新布局
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    return YES;
//}

//计算单元格宽高
/**
 *  准备好布局时调用
 *  布局准备方法 当collectionView的布局发生变化时 会被调用
 *  通常是做布局的准备工作 itemSize.....
 *  UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的
 */
- (void)prepareLayout{
    
    //item的最小间距
    CGFloat space = self.minimumInteritemSpacing;
    CGFloat contentSize = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    //每个单元格的宽度
    CGFloat itemWidth = (contentSize - (space * (self.lineNum-1)))/self.lineNum;
    //根据宽度计算每个单元格的属性
    [self computeAttributesWithItemWidth:itemWidth];
}

- (void)computeAttributesWithItemWidth:(CGFloat)width{
    
    //存储每列个数和每列总高度的数组
    CGFloat columnHeight[self.lineNum];
    CGFloat columnNum[self.lineNum];
    //初始化数组
    for (int i = 0; i < self.lineNum; i ++) {
        columnNum[i] = 0;
        //sectionInset  UIEdgeInsets类型  边距
        columnHeight[i] = self.sectionInset.top;
    }
    
    //循环创建每个单元格的 attributes
    for (int i = 0; i < self.dataList.count; i ++) {
        int index = [self computerMinHeightWithArray:columnHeight];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        //计算每个item的位置，大小
        CGFloat itemX = index * (width+self.minimumLineSpacing) + self.sectionInset.left;
        CGFloat itemY = columnHeight[index];
        CGFloat itemHeight = [self makeNum];
        
        attributes.frame = CGRectMake(itemX, itemY, width, itemHeight);
        
        [self.attributesArray addObject:attributes];
        
        columnHeight[index] += itemHeight+self.minimumInteritemSpacing;
        columnNum[index] ++;
    }
    
    //计算最高列
    int maxIndex = [self computerMaxHeightWithArray:columnHeight];
    _maxHeight = columnHeight[maxIndex];
    
    CGFloat aveHeight = (columnHeight[maxIndex] - self.sectionInset.top - columnNum[maxIndex]*self.minimumLineSpacing)/columnNum[maxIndex];
    self.itemSize = CGSizeMake(width, aveHeight);
    
}

//生成随机数
- (CGFloat)makeNum{
    
    CGFloat height = arc4random_uniform(255);
    if (height >= 10) {
        return height;
    }else{
        return [self makeNum];
    }
}

//寻找最短列
- (int)computerMinHeightWithArray:(CGFloat *)array{
    
    int minIndex = 0;
    CGFloat min = CGFLOAT_MAX;
    for (int i = 0; i < self.lineNum; i ++) {
        if (min > array[i]) {
            minIndex = i;
            min = array[i];
        }
    }
    
    return minIndex;
}

//寻找最高列
- (int)computerMaxHeightWithArray:(CGFloat *)array{
    
    int maxIndex = 0;
    CGFloat max = 0;
    for (int i = 0; i < self.lineNum; i ++) {
        if (max < array[i]) {
            maxIndex = i;
            max = array[i];
        }
    }
    
    return maxIndex;
}

//返回collectionView视图中所有视图的属性(UICollectionViewLayoutAttributes)数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}

//内容尺寸
- (CGSize)collectionViewContentSize{
    
    return CGSizeMake(self.collectionView.bounds.size.width, _maxHeight);
    
}

////返回indexPath对应item的属性
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//}
//
////设置collectionView的可显示范围
//- (CGSize)collectionViewContentSize{
//    return CGSizeMake(0, 0);
//}

@end
