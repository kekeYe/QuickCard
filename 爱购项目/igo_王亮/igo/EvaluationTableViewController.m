//
//  EvaluationTableViewController.m
//  igo
//
//  Created by Destiny on 15/9/25.
//  Copyright (c) 2015年 Destiny. All rights reserved.
//

#import "EvaluationTableViewController.h"
#import "AFNetworking.h"
#import "Comment.h"
#import "EvaluationCell.h"
#import "UIImageView+AFNetworking.h"

@interface EvaluationTableViewController ()
@property(nonatomic,retain)NSMutableArray *commentArr;
@end

@implementation EvaluationTableViewController

- (NSMutableArray *)commentArr
{
    if(_commentArr == nil)
    {
        _commentArr = [NSMutableArray array];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[NSString stringWithFormat:@"%d",self.g_id] forKey:@"g_id"];
        [manager POST:@"http://localhost:8888/igo/comment.php?action=show" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            NSArray *dataArr = [dict valueForKey:@"data"];
            for(NSDictionary *dict in dataArr)
            {
                Comment *comment = [Comment CommentWithDictionary:dict];
                [_commentArr addObject:comment];
            }
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
            NSLog(@"错误%@",error);
        }];
    }
    return _commentArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.commentArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"evaluationCellID";
    EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    Comment *comment = [self.commentArr objectAtIndex:indexPath.row];
    NSURL *u_url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8888/igo/igo_image/%@",comment.u_image]];
    [cell.E_img setImageWithURL:u_url];
    cell.E_name.text = comment.u_name;
    cell.E_evaluation.text = comment.c_comment;
    return cell;
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
