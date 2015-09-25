//
//  HomeTableViewController.m
//  igo
//
//  Created by Destiny on 15/9/21.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import "HomeTableViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "Goods.h"
#import "GoodsCell.h"
#import "GoodsViewController.h"
#import "MyViewController.h"

@interface HomeTableViewController ()
@property(nonatomic,retain)NSMutableArray *goodsArr;


@end

@implementation HomeTableViewController

- (NSMutableArray *)goodsArr
{
    if(_goodsArr == nil)
    {
        _goodsArr = [NSMutableArray array];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        [manager POST:@"http://localhost:8888/igo/goods.php?action=show" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.goodsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"goodsCellID";
    
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    Goods *goods = [self.goodsArr objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/igo/igo_image/%@",goods.g_img]];
    [cell.goods_img setImageWithURL:url];
    cell.goods_name.text = goods.g_name;
    cell.goods_price.text = [NSString stringWithFormat:@"%d",goods.g_price];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goods *goods = [self.goodsArr objectAtIndex:indexPath.row];
    int gid = goods.g_id;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GoodsViewController *gVC = [storyboard instantiateViewControllerWithIdentifier:@"goodsVC"];
    gVC.g_id = gid;
    gVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:gVC animated:YES];
    gVC.hidesBottomBarWhenPushed = NO;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
