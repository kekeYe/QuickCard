//
//  FirstViewController.m
//  igo
//
//  Created by administrator on 15/9/21.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "FirstViewController.h"
#import "Goods.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "GoodsCell.h"
#import "GoodsDetailTableViewController.h"


@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong)NSMutableArray *goodsArr;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

/**
 *  网路请求数据并进行懒加载
 *
 *  @return 商品信息的数组
 */
- (NSMutableArray *)goodsArr{

    if (_goodsArr==nil) {
        
        _goodsArr = [NSMutableArray array];
        
        //网络请求数据
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        
        NSString *urlPath = [NSString stringWithFormat:@"http://localhost:8888/igo/indexs.php"];
        [mgr GET:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSArray *dataArr = dict[@"data"];
            
            for (NSDictionary *dict in dataArr ) {
                
                //实例一个实体类
                Goods *goods = [Goods goodsWithDict:dict];
                [_goodsArr addObject:goods];
                
            }
            
            [self.myTableView reloadData]; //因为网络请求需要时间，所以放在这里
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }
    
    return _goodsArr;
}

/**
 *  section 中的行数 是数组里面的元素的个数
 *
 *  @param tableView 商品信息展览
 *  @param section
 *
 *  @return 行数
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.goodsArr.count;
    
}

/**
 *  每行的数据载入
 *
 *  @param tableView 商品信息展览
 *  @param indexPath
 *
 *  @return 商品信息
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //cell的重用
    
    NSString *goodsCellID=@"goodsID";
   GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsCellID];
    
    if (cell==nil) {
        
        cell = [[GoodsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:goodsCellID];
        
    }
    
    //当前行的内容对应数组中相应下标的的元素
     Goods *goods = [self.goodsArr objectAtIndex:indexPath.row];
    
    cell.gnameLabel.text = goods.gname;
    cell.priceLabel.text = [NSString stringWithFormat:@"%d",goods.price];
    
    //网络请求获得的图片加载进页面
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/igo/%@",goods.icon]];
    [cell.goodsIcon setImageWithURL:url];
    
    //设置箭头
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
    
}

/**
 *  对选中行进行的操作
 *
 *  @param tableView
 *  @param indexPath
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Goods *goods=[self.goodsArr objectAtIndex:indexPath.row];
    int gid =goods.gid;
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GoodsDetailTableViewController *goodDetailVC=[storyboard instantiateViewControllerWithIdentifier:@"GoodDetailID"];
    
    //界面传值
    goodDetailVC.gid=gid;
    
    [self.navigationController pushViewController:goodDetailVC animated:YES];
    
 }

@end
