//
//  FSFriendListCollectionCell.m
//  FriendsListDemo
//
//  Created by tq001 on 2019/5/20.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "FSFriendListCollectionCell.h"

#define FSScreenW [UIScreen mainScreen].bounds.size.width

@interface FSFriendListCollectionCell ()

@end

@implementation FSFriendListCollectionCell
#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //1、添加子视图
        [self addSubviews];
    }
    return self;
}

#pragma mark 设置UI界面
- (void)addSubviews {
    //1、添加图标
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.cornerRadius = 50/2;
    imageView.layer.masksToBounds = YES;
    imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    //2、添加标题
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //3、添加签名
    UILabel *detailsLabel = [[UILabel alloc] init];
    detailsLabel.font = [UIFont systemFontOfSize:14];
    detailsLabel.textAlignment = NSTextAlignmentLeft;
    detailsLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:detailsLabel];
    self.detailsLabel = detailsLabel;
    
}

/**
 调用父类布局子视图
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    //1、图标
    self.imageView.frame = CGRectMake(10, 10, 50, 50);
    
    //2、标题
    CGFloat nameX = CGRectGetMaxX(self.imageView.frame) + 10;
    CGFloat nameW = FSScreenW - nameX -10;
    self.nameLabel.frame = CGRectMake(nameX, 10, nameW, 20);
    
    //3、人数
    CGFloat detailsX = CGRectGetMaxX(self.imageView.frame) + 10;
    CGFloat detailsY = CGRectGetMaxY(self.nameLabel.frame) + 5;
    CGFloat detailsW = FSScreenW - detailsX - 10;
    self.detailsLabel.frame = CGRectMake(detailsX, detailsY, detailsW, 20);
}
@end
