//
//  FSFriendHeaderReusableView.h
//  FriendsListDemo
//
//  Created by tq001 on 2019/5/21.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FSFriendHeaderReusableView;
@protocol FSFriendHeaderReusableViewDelegate <NSObject>

- (void)friendHeaderReusableView:(FSFriendHeaderReusableView *)friendHeaderReusableView didSelectItemAtSection:(NSInteger)section;

@end

@interface FSFriendHeaderReusableView : UICollectionReusableView

@property(nonatomic,weak) id <FSFriendHeaderReusableViewDelegate>delegte;

/**
 图标
 */
@property(nonatomic,weak) UIImageView *imageView;
/**
 标题
 */
@property(nonatomic,weak) UILabel *titleLabel;
/**
 人数
 */
@property(nonatomic,weak) UILabel *numLabel;
@end

NS_ASSUME_NONNULL_END
