//
//  GoodsDetailTableViewController.m
//  igo
//
//  Created by administrator on 15/9/22.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "GoodsDetailTableViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Goods.h"
#import "goodDetailTableViewCell.h"


@interface GoodsDetailTableViewController ()
@property(nonatomic,strong)Goods *goods;

@property (strong, nonatomic) IBOutlet UITableView *goodsTableview;

@property(strong,nonatomic) goodDetailTableViewCell *headercell;  // 商品详细页面展示中页面的第一行，使用自定义的cell

@end
@implementation GoodsDetailTableViewController

/**
 *  通过界面传值获得的gid 进行数据请求 并且获得这一条商品的信息
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSString *strPath = [NSString stringWithFormat:@"http://localhost:8888/igo/goodsdetail.php?gid=%d",self.gid];
    
    [mgr GET:strPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *dataArr = dict[@"data"];
        
        for (NSDictionary *dict in dataArr) {
            
            self.goods = [Goods goodsWithDict:dict];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/igo/%@",self.goods.icon]];
            [self.headercell.goodIcon setImageWithURL:url];
            
            self.headercell.gname.text =self.goods.gname;
            
            self.headercell.price.text = [NSString stringWithFormat:@"%d",self.goods.price];
            
           
        }
        
        //对某一行的数据进行更新
        [self.goodsTableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"reason:%@",error);
        
    }];
   
    //设置tableview页面的分割方式
    
    self.goodsTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


/**
 *  tableview展示三行数据
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}

/**
 *  每行的信息展示
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [UITableViewCell new];
    
    //第一行，将自定义的xib加载进入cell中
    if (indexPath.row==0) {
     
      self.headercell = [[[NSBundle mainBundle]loadNibNamed:@"goodDetailTableViewCell" owner:self options:nil] firstObject];
        
         [cell.contentView addSubview:self.headercell];
        
    }else if (indexPath.row==1){
    
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 250, 50)];
        [lab setText:@"已选“XL” “red”"];
        
        [cell.contentView addSubview:lab];
    
        
    }else if (indexPath.row==2){
    
      
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 250, 50)];
        [lab setText:@"宝贝评价"];
        
        [cell.contentView addSubview:lab];
    }
    
    return cell;
    

}

/**
 *  设置行高
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 223;
    }
    else{
    
        return 44;
    }
    
}

@end
