
//
//  HomeTableViewCell.m
//  iGou
//
//  Created by administrator on 9/21/15.
//  Copyright © 2015 xingxing. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+AFNetworking.h"
@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsIcon;
@property (weak, nonatomic) IBOutlet UILabel *gnamelbl;
@property (weak, nonatomic) IBOutlet UILabel *pricelbl;

@end
@implementation HomeTableViewCell

- (void)setGoods:(Goods *)goods
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/igo/%@",goods.icon]];
    /**
     *  1.化为data
     */
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    self.goodsIcon.image = [UIImage imageWithData:data];
    /**
     *  2.
     */
    [self.goodsIcon setImageWithURL:url];
    self.gnamelbl.text = goods.gname;
    self.pricelbl.text = [NSString stringWithFormat:@"%.2f",goods.price];
    
}

@end
