//
//  goodsVC.m
//  iGou
//
//  Created by administrator on 9/24/15.
//  Copyright © 2015 xingxing. All rights reserved.
//

#import "goodsVC.h"
#import "AFNetworking.h"
#import "Goods.h"
@interface goodsVC ()

@property(nonatomic,strong)NSMutableArray *goodsDetailArray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation goodsVC

-(NSMutableArray *)goodsDetailArray{
    if (_goodsDetailArray==nil) {
        _goodsDetailArray = [NSMutableArray array];
        
    }
    return _goodsDetailArray ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableview.scrollEnabled = NO;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.separatorStyle = NO;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];//单例方法
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSString *urlPath = [NSString stringWithFormat:@"http://localhost:8888/igo/goodsDetail.php?gid=%d",self.gid];
    [mgr GET: urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         NSDictionary *dict = (NSDictionary *)responseObject;
         
         NSArray *dataArr = [dict valueForKey:@"data"];
         for (NSDictionary *dict in dataArr)
         {
             Goods *goods = [Goods goodsWithDict:dict];
             [self.goodsDetailArray addObject:goods];
         }
         [self.tableview reloadData];
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"%@",error);
     }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"goodsCell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    Goods *goods = [self.goodsDetailArray firstObject];
    if (indexPath.row == 0) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 310, 150)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/igo/%@",goods.icon]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        view.image = [UIImage imageWithData:data];
        
        UILabel *gnamelbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 155, 310, 50)];
        gnamelbl.numberOfLines = 0;
        gnamelbl.text = goods.gname;
        
        UILabel *pricelbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 205, 100, 20)];
        pricelbl.text = [NSString stringWithFormat:@"价格:%.2lf",goods.price];
        pricelbl.font = [UIFont systemFontOfSize:15];
        pricelbl.textColor = [UIColor redColor];
        
        [cell addSubview:view];
        [cell addSubview:gnamelbl];
        [cell addSubview:pricelbl];
    }
    
    return cell;
}









@end
