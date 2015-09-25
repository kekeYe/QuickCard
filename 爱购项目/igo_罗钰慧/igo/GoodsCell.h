//
//  GoodsCell.h
//  igo
//
//  Created by administrator on 15/9/22.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UITableViewCell
//自定义cell
@property (weak, nonatomic) IBOutlet UIImageView *goodsIcon;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *gnameLabel;

@end
