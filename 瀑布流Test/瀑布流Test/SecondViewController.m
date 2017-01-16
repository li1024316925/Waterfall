//
//  SecondViewController.m
//  瀑布流Test
//
//  Created by LLQ on 17/1/13.
//  Copyright © 2017年 LLQ. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height

#import "SecondViewController.h"
#import "SecondCollectionViewCell.h"
#import "LLQHorizontalWaterfallFlowLayout.h"
#import "SecondCollectionReusableView.h"

@interface SecondViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation SecondViewController

//lazy
- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"横向瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self createView];
    
}

- (void)loadData{
    [self.dataList addObject:@[@"保温饭盒",@"闷罐",@"肯德基",@"女鞋秋",@"女鞋",@"外套女秋冬长款",@"外套女秋冬",@"山药片怀恋",@"山药片"]];
    [self.dataList addObject:@[@"没有尽兴？继续买",@"套装裙 两件套",@"长款毛衣",@"针织裙秋冬",@"焖烧壶",@"长裙",@"修身连衣裙",@"外套",@"磨砂短女靴",@"女鞋秋冬"]];
}

- (void)createView{
    
    LLQHorizontalWaterfallFlowLayout *layout = [[LLQHorizontalWaterfallFlowLayout alloc] init];
    layout.dataList = self.dataList;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHight) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[SecondCollectionViewCell class] forCellWithReuseIdentifier:@"textCell"];
    [_collectionView registerClass:[SecondCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"class_header"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
}


#pragma mark ------ UICollectionViewDataSource and UICollectionViewDelegate

//组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataList.count;
}

//每组单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sectionArray = self.dataList[section];
    return sectionArray.count;
}

//单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"textCell" forIndexPath:indexPath];
    NSArray *array = self.dataList[indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
    
}

//头尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        SecondCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"class_header" forIndexPath:indexPath];
        headerView.textLable.text = indexPath.section==0 ? @"历史搜索" : @"搜索发现";
        headerView.backgroundColor = [UIColor whiteColor];
        return headerView;
    }
    return nil;
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
