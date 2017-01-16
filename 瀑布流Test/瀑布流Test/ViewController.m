//
//  ViewController.m
//  瀑布流Test
//
//  Created by LLQ on 16/12/30.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "LLQWaterfallFlowLayout.h"
#import "SecondViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *cellHeightCacheArray;

@end

@implementation ViewController

//lazy
- (NSMutableArray *)dataSource{
    
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
    
}
- (NSMutableArray *)cellHeightCacheArray{
    
    if (_cellHeightCacheArray == nil) {
        _cellHeightCacheArray = [[NSMutableArray alloc] init];
    }
    
    return _cellHeightCacheArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"纵向瀑布流";
    
    [self loadData];
    [self createCollectionView];
    
}

- (void)loadData{
    
    for (int i = 0; i < 50; i ++) {
        UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [self.dataSource addObject:color];
    }
    
}

- (void)createCollectionView{
    
    LLQWaterfallFlowLayout *layout = [[LLQWaterfallFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.lineNum = 3;
    layout.dataList = self.dataSource;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"colorCell"];
    
    [self.view addSubview:_collectionView];
    
}


#pragma mark ------ UICollectionViewDelegate and UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
    cell.backgroundColor = self.dataSource[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
