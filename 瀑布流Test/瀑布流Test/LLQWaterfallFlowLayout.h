//
//  LLQWaterfallFlowLayout.h
//  瀑布流Test
//
//  Created by LLQ on 17/1/1.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLQWaterfallFlowLayout : UICollectionViewFlowLayout


/**
 列数
 */
@property (nonatomic, assign) int lineNum;


/**
 数据数组
 */
@property (nonatomic, strong) NSArray *dataList;

@end
