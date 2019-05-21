//
//  FSFriendListCollectionCell.h
//  FriendsListDemo
//
//  Created by tq001 on 2019/5/20.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FSFriendListCollectionCell : UICollectionViewCell
@property(nonatomic,weak) UIImageView *imageView;
@property(nonatomic,weak) UILabel *nameLabel;
@property(nonatomic,weak) UILabel *detailsLabel;
@end

NS_ASSUME_NONNULL_END
