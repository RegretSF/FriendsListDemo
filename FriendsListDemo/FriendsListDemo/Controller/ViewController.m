//
//  ViewController.m
//  FriendsListDemo
//
//  Created by tq001 on 2019/5/20.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "ViewController.h"
#import "FSFriendHeaderReusableView.h"
#import "FSFriendListCollectionCell.h"

#define FSScreenW [UIScreen mainScreen].bounds.size.width
#define FSScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,FSFriendHeaderReusableViewDelegate>
/**
 添加collectionView
 */
@property(nonatomic,strong) UICollectionView *collectionView;
/**
 好友组头列表数组
 */
@property(nonatomic,strong) NSArray *headerArr;
/**
 好友列表数据
 */
@property (nonatomic, strong) NSMutableArray * dataArr;
/**
 存储是否展开的BOOL值
 */
@property (nonatomic, strong) NSMutableArray * boolArr;

@end

@implementation ViewController
//****************************cell的ID*************************//
static NSString * const FSFriendListCollectionCellID = @"FSFriendListCollectionCellID";
static NSString * const FSFriendHeaderReusableViewID = @"FSFriendHeaderReusableViewID";
//*************************************************************//
#pragma mark 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableArray *)boolArr {
    if (!_boolArr) {
        _boolArr = [[NSMutableArray alloc] init];
    }
    return _boolArr;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //1.创建layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(FSScreenW, 70);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(FSScreenW, 40);
        
        //2.创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        
        [_collectionView registerClass:[FSFriendHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FSFriendHeaderReusableViewID];
        [_collectionView registerClass:[FSFriendListCollectionCell class] forCellWithReuseIdentifier:FSFriendListCollectionCellID];
    }
    return _collectionView;
}

#pragma mark 系统回调函数
- (void)viewDidLoad {
    [super viewDidLoad];
    //0、初始化一些值
    self.navigationItem.title = @"好友列表";
    
    //1、添加子视图
    [self addSubviews];
    
    //2、准备数据
    [self getListData];
}

#pragma mark 准备数据
- (void)getListData {
    //1、准备组头的数据
    NSArray *headerArr = [NSArray arrayWithObjects:@"特别关心", @"我的好友", @"朋友", @"家人",nil];
    self.headerArr = headerArr;
    
    //2、准备单元格的数据
    NSArray *itemArr = [NSArray arrayWithObjects:@5, @10, @7,@3,  nil];
    for (int i=0; i<self.headerArr.count; i++) {
        //1、所有的分组默认关闭
        [self.boolArr addObject:@NO];
        
        //2、给每个分组添加数据
        NSMutableArray * friendArr = [[NSMutableArray alloc] init];
        for (int j=0; j<[itemArr[i] intValue]; j++) {
            [friendArr addObject:@(j)];
        }
        [self.dataArr addObject:friendArr];
        
    }
    
    [self.collectionView reloadData];
}

#pragma mark 设置UI界面
- (void)addSubviews {
    //1、添加collectionView
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark FSFriendHeaderReusableViewDelegate
- (void)friendHeaderReusableView:(FSFriendHeaderReusableView *)friendHeaderReusableView didSelectItemAtSection:(NSInteger)section {
    
    //判断改变bool值
    if ([self.boolArr[section] boolValue] == YES) {
        [self.boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [self.boolArr replaceObjectAtIndex:section withObject:@YES];
    }
    //刷新某个section
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];;
}

#pragma mark UICollectionViewDataSource,UICollectionViewDelegate
//确定组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.headerArr.count;
}

//确定组内行数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //判断是否展开，如果未展开则返回0
    if ([self.boolArr[section] boolValue] == NO) {
        return 0;
    }else {
        return [self.dataArr[section] count];
    }

}

//添加组头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FSFriendHeaderReusableView *reusView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FSFriendHeaderReusableViewID forIndexPath:indexPath];
    reusView.delegte = self;
    reusView.backgroundColor = [UIColor whiteColor];
    reusView.tag = indexPath.section;
    
    //三目运算选择展开或者闭合时候的图标
    reusView.imageView.image = [_boolArr[indexPath.section] boolValue] ? [UIImage imageNamed:[NSString stringWithFormat:@"zhankai"]] : [UIImage imageNamed:[NSString stringWithFormat:@"shouqi"]];
    
    reusView.titleLabel.text = self.headerArr[indexPath.section];
    reusView.numLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)indexPath.section, (unsigned long)[self.dataArr[indexPath.section] count]];
    
    return reusView;
}

//细化单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FSFriendListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FSFriendListCollectionCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.nameLabel.text = [NSString stringWithFormat:@"好友%ld", (long)indexPath.item];
    cell.detailsLabel.text = [NSString stringWithFormat:@"签名%ld", (long)indexPath.item];
    return cell;
}

@end
