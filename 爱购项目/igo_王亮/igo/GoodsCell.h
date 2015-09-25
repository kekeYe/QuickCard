//
//  GoodsCell.h
//  igo
//
//  Created by Destiny on 15/9/21.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;

@end
