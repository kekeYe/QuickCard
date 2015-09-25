//
//  goodDetailTableViewCell.h
//  igo
//
//  Created by administrator on 15/9/24.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
//自定义xib文件
@interface goodDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodIcon;

@property (weak, nonatomic) IBOutlet UILabel *gname;

@property (weak, nonatomic) IBOutlet UILabel *price;

@end
