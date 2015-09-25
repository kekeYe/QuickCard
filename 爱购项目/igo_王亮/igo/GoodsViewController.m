//
//  GoodsViewController.m
//  igo
//
//  Created by Destiny on 15/9/24.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsDetailCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Goods.h"
#import "EvaluationTableViewController.h"

@interface GoodsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSMutableArray *goodsArr;
- (IBAction)btnCommentClick;
- (IBAction)btnChoose;
@property (weak, nonatomic) IBOutlet UIView *chooseView;

@end

@implementation GoodsViewController

- (NSMutableArray *)goodsArr
{
    if(_goodsArr == nil)
    {
        _goodsArr = [NSMutableArray array];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[NSString stringWithFormat:@"%d",self.g_id] forKey:@"g_id"];
        [manager POST:@"http://localhost:8888/igo/goods.php?action=select_goods" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            NSArray *dataArr = [dict valueForKey:@"data"];
            for(NSDictionary *dict in dataArr)
            {
                Goods *goods = [Goods GoodsWithDictionary:dict];
                [_goodsArr addObject:goods];
            }
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
            NSLog(@"错误%@",error);
        }];
    }
    return _goodsArr;
}

- (IBAction)btnCommentClick {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EvaluationTableViewController *evaluationVC = [sb instantiateViewControllerWithIdentifier:@"evaluationVC"];
    evaluationVC.g_id = self.g_id;
    evaluationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:evaluationVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (IBAction)btnChoose {
    self.chooseView.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.chooseView.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"goodsDetailID";
    GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Goods *goods = [self.goodsArr firstObject];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/igo/igo_image/%@",goods.g_img]];
    [cell.g_image setImageWithURL:url];
    cell.g_describe.text = goods.g_describe;
    cell.g_price.text = [NSString stringWithFormat:@"%d",goods.g_price];
    return cell;
}
@end
