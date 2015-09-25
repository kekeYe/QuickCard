//
//  HomeViewController.m
//  iGou
//
//  Created by administrator on 9/21/15.
//  Copyright (c) 2015 xingxing. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "Goods.h"
#import "AFNetworking.h"
#import "goodsVC.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytableview;

@property(nonatomic,strong)NSMutableArray *goodsArr;

@end

@implementation HomeViewController

- (NSMutableArray *)goodsArr
{
    if (_goodsArr == nil) {
        _goodsArr = [NSMutableArray array];
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];//单例方法
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        
        //NSString *urlPath = [NSString stringWithFormat:@"http://localhost:8888/igo/"];
        [mgr GET:@"http://localhost:8888/igo/index.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            int code = [[dict valueForKey:@"code"]integerValue];
            if (code == 200) {
                NSArray *dataArr = [dict valueForKey:@"data"];
                for (NSDictionary *dict in dataArr) {
                    Goods *goods = [Goods goodsWithDict:dict];
                    [_goodsArr addObject:goods];
                }
            }
//            NSLog(@"%@",_goodsArr);
            [self.mytableview reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
    return _goodsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytableview.dataSource = self;
    self.mytableview.delegate = self;
    NSLog(@"%lu",(unsigned long)self.goodsArr.count);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"goodsCellID";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];//向右箭头
    Goods *goods = [self.goodsArr objectAtIndex:indexPath.row];
    
//    cell.detailTextLabel.text = @"wode";
    [cell setGoods:goods];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goods *goods = [self.goodsArr objectAtIndex:indexPath.row];
    int gid = goods.gid;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    goodsVC *gVC = [storyboard instantiateViewControllerWithIdentifier:@"goodsDetailVC"];
    gVC.gid = gid;
    gVC.title = goods.gname;
    gVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gVC animated:YES];
    gVC.hidesBottomBarWhenPushed = NO;
}












@end
