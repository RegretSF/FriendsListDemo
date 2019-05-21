//
//  FSFriendHeaderReusableView.m
//  FriendsListDemo
//
//  Created by tq001 on 2019/5/21.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "FSFriendHeaderReusableView.h"

#define FSScreenW [UIScreen mainScreen].bounds.size.width

@interface FSFriendHeaderReusableView ()

@end

@implementation FSFriendHeaderReusableView
#pragma mark 初始化
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //0、未父类视图添加响应事件
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
        [self addGestureRecognizer:tapGes];
        
        //1、添加子视图
        [self addSubviews];
    }
    return self;
}

#pragma mark 设置UI界面
- (void)addSubviews {
    //1、添加图标
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    //2、添加标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    //3、添加人数
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.font = [UIFont systemFontOfSize:14];
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:numLabel];
    self.numLabel = numLabel;
    
}

/**
 调用父类布局子视图
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    //1、图标
    self.imageView.frame = CGRectMake(10, 10, 20, 20);
    
    //2、标题
    CGFloat numW = 60;
    CGFloat titleX = CGRectGetMaxX(self.imageView.frame) + 10;
    CGFloat titleW = FSScreenW - titleX - numW -15;
    self.titleLabel.frame = CGRectMake(titleX, 10, titleW, 20);
    
    //3、人数
    CGFloat numX = FSScreenW - numW - 10;
    self.numLabel.frame = CGRectMake(numX, 10, numW, 20);
}

#pragma nmark 监听事件
- (void)clickView:(UITapGestureRecognizer *)tapGes {
    if ([self.delegte respondsToSelector:@selector(friendHeaderReusableView:didSelectItemAtSection:)]) {
        [self.delegte friendHeaderReusableView:self didSelectItemAtSection:self.tag];
    }
}
@end
