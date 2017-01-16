//
//  LLQHorizontalWaterfallFlowLayout.m
//  瀑布流Test
//
//  Created by LLQ on 17/1/13.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height

#import "LLQHorizontalWaterfallFlowLayout.h"

@interface LLQHorizontalWaterfallFlowLayout ()

@property (nonatomic, strong)NSMutableArray *attributesArray; //存放item的属性数组

@end

@implementation LLQHorizontalWaterfallFlowLayout

//lazy
- (NSMutableArray *)attributesArray{
    if (_attributesArray == nil) {
        _attributesArray = [[NSMutableArray alloc] init];
    }
    return _attributesArray;
}

/**
 *  准备好布局时调用
 *  布局准备方法 当collectionView的布局发生变化时 会被调用
 *  通常是做布局的准备工作 itemSize.....
 *  UICollectionView 的 contentSize 是根据 itemSize 动态计算出来的
 */
- (void)prepareLayout{
    [self computeAttributes];
}

- (BOOL)shouldGroupAccessibilityChildren{
    return YES;
}

//计算每个单元格的属性
- (void)computeAttributes{
    
    //存贮每行个数
    NSMutableArray *lineNum = [[NSMutableArray alloc] init];
    [lineNum insertObject:@0 atIndex:0];
    //储存每行宽度
    NSMutableArray *lineWidth = [[NSMutableArray alloc] init];
    [lineWidth insertObject:@10.0 atIndex:0];
    //记录当前高度
    CGFloat verticalHeight = 10;
    //当前添加的行号
    int index = 0;
    
    for (int k = 0; k < self.dataList.count; k ++) {
        NSArray *array = self.dataList[k];
        
        //添加一个组头
        UICollectionViewLayoutAttributes *headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:k]];
        headerAttributes.frame = CGRectMake(0, verticalHeight + k*50, kScreenWidth, 50);
        [self.attributesArray addObject:headerAttributes];
        //相当于添加了一行
        [lineNum addObject:@1];
        [lineWidth addObject:@(kScreenWidth)];
        //添加组头，不需要计算组头的高度，单元格会自动适配到组头下面
        verticalHeight += 10;
        index ++;
        
        for (int i = 0; i < array.count; i ++) {
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:k]];
            //计算宽度
            CGFloat width = [self computerWidthWithString:array[i]];
            //计算位置
            CGFloat X;
            CGFloat Y;
            CGFloat indexWidth = [lineWidth[index] floatValue];  //当前行宽
            if ((indexWidth+width+10) <= self.collectionView.bounds.size.width) {
                //如果添加一个单元格，此行宽度还小于控件宽度，那就添加到此行
                X = [lineWidth[index] floatValue];
                Y = verticalHeight;
                lineNum[index] = @([lineNum[index] intValue]+1);
                lineWidth[index] = @([lineWidth[index] floatValue]+width+10);
            }else{
                //如果添加一个单元格，此行宽度大于控件宽度，那就另起一行
                index++;
                verticalHeight += 50;
                Y = verticalHeight;
                X = 10.0;
                [lineNum addObject:@(1)];
                [lineWidth addObject:@(width+10+10)];
            }
            
            attributes.frame = CGRectMake(X, Y, width, 40);
            [self.attributesArray addObject:attributes];
            
            //设置平均item属性
            int maxIndex = [self computerMAXlineWithArray:lineWidth];
            CGFloat aveWidth = ([lineWidth[maxIndex] floatValue]-[lineNum[maxIndex] intValue]*10-10)/[lineNum[maxIndex] intValue];
            self.itemSize = CGSizeMake(aveWidth, 40);
            
        }
    }
    
}

//返回属性数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}

//计算单元格宽度
- (CGFloat)computerWidthWithString:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(1000, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    return rect.size.width+20;
}

//计算最宽行
- (int)computerMAXlineWithArray:(NSArray *)array{
    
    int maxIndex = 0;
    CGFloat maxfloat = 0;
    for (int i=0; i<array.count; i++) {
        CGFloat ifloat = [array[i] floatValue];
        if (ifloat > maxfloat) {
            maxIndex = i;
            maxfloat = ifloat;
        }
    }
    
    return maxIndex;
}

@end
