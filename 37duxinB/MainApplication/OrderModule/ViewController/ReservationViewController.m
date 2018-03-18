//
//  ReservationViewController.m
//  37duxinB
//
//  Created by 37duxin on 06/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ReservationViewController.h"
#import "ReservationWatingCell.h"
#import "ReservationWatingForCommentCell.h"
#import "ReservationOrderRecordCell.h"
#import "OrderRecordViewController.h"
#import "OrderTitleView.h"
#import "ReservationOrderModel.h"
#import "ChatWithPaymentVC.h"
#import "OrderDetailViewController.h"
#import "PopRecordView.h"
#import "PopBackgroundView.h"

@interface ReservationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    OrderTitleView  *_titleView;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation ReservationViewController

-(void)fetchData:(NSMutableDictionary *)dic{
    HttpsManager *httpsManager = [[HttpsManager alloc]init];
    [httpsManager getServerAPI:FetchBReservationOrders deliveryDic:dic successful:^(id responseObject) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSDictionary *responData = (NSDictionary *)responseObject;
            if ([[responData objectForKey:@"code"] integerValue] ==200) {
                NSDictionary *dataDic = [responData objectForKey:@"data"];
                NSArray *array = [dataDic objectForKey:@"result"];
                [_dataArray removeAllObjects];
                if (array.count != 0 ) {
                    [ReservationOrderModel fetchArray:array model:^(BOOL stop, ReservationOrderModel *model) {
                        [_dataArray addObject:model];
                        if (stop) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [_tableView reloadData];
                                [_tableView.mj_header endRefreshing];
                            });
                        }
                    }];
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tableView reloadData];
                        [_tableView.mj_header endRefreshing];
                    });
                    
                }
         
            }
            else
            {
                [SVHUD  showErrorWithDelay:@"获取初次订单失败" time:0.8];
            
            }
            
        });
        
    } fail:^(id error) {
        [self waring];
    }];
}

-(void)waring{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD  showErrorWithDelay:@"获取初次订单失败" time:0.8];
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self selectedIndex:0];
    
}

-(void)initData{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)initUI{
    
    __weak typeof(self) weakSelf = self;
    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0,Height_NavBar+50,SIZE.width, 50) withArray:@[@"全部",@"待咨询",@"待评价",@"已评价"]];
    _titleView.indexBlock = ^(NSInteger index) {
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_titleView];
    
    [_titleView.btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        btn.titleLabel.font = FONT_13;
    }];
    
    [_titleView.btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        btn.titleLabel.font = FONT_13;
    }];
    
    CGFloat tabbarHeight = Height_TabBar;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,bottom(_titleView),SIZE.width,SIZE.height-bottom(_titleView)-tabbarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = Color_F1F1F1;
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = Color_F1F1F1;
    return view;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ReservationOrderModel *model = _dataArray[indexPath.section];
    if ([model.orderStatus integerValue] == 2 )
    {
        return 170.0f;
    }
    else
    {
        return 210.0f;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ReservationOrderModel *model = _dataArray[indexPath.section];
    if ([model.orderStatus integerValue] == 1)
    {
        static NSString *ReservationWatingCellID = @"ReservationWatingCellID";
        ReservationWatingCell *cell = [tableView dequeueReusableCellWithIdentifier:ReservationWatingCellID];
        if (cell == nil) {
            cell = [[ReservationWatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReservationWatingCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        [cell updateUI:model];
        cell.contactCustomerBlock = ^(NSInteger tag) {
            ReservationOrderModel *model = _dataArray[tag];
            [self chattingWithUser:model.consultantUserId];
        };
        return cell;
    }
    else
    if ([model.orderStatus integerValue] == 2)
    {
        static NSString *ReservationWatingForCommentCellID = @"ReservationWatingForCommentCellID";
        ReservationWatingForCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ReservationWatingForCommentCellID];
        if (cell == nil) {
            cell = [[ReservationWatingForCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReservationWatingForCommentCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        [cell updateUI:model];
        return cell;
    }
    else
    {
        static NSString *ReservationOrderRecordCellID = @"ReservationOrderRecordCellID";
        ReservationOrderRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ReservationOrderRecordCellID];
        if (cell == nil) {
            cell = [[ReservationOrderRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReservationOrderRecordCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        [cell updateUI:model];
        cell.orderRecordBlock = ^(NSInteger tag) {
            [self orderRecordAction:model.orderId];
        };
        return cell;
        
        
    }

}

-(void)chattingWithUser:(NSString *)idString{
    
   
    ChatWithPaymentVC *vc = [[ChatWithPaymentVC alloc] initWithConversationChatter:@"iostest" conversationType:EMConversationTypeChat];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationController pushViewController:vc animated:YES];

}

-(void)orderRecordAction:(NSString *)idString{
    
    PopRecordView *view = [[PopRecordView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width-20, 359)];
    PopBackgroundView *backgroundView = [[PopBackgroundView  alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height) withPopView:view];
    __weak typeof(backgroundView) weakBackgroundView = backgroundView;
    backgroundView.confrimBlock = ^(NSDictionary *dic) {
  
        [self postDic:dic withId:idString popView:weakBackgroundView];
        
    };

}

-(void)postDic:(NSDictionary *)dic withId:(NSString *)idString popView:(PopBackgroundView *)popView{
    
    HttpsManager *httpsManager = [HttpsManager new];
    NSMutableDictionary *dataDic = (NSMutableDictionary *)dic;
    NSString *urlString = [NSString stringWithFormat:@"%@%@",PostCreateOrderRecord,idString];
    NSLog(@"dataDic==>%@urlString==>%@",dataDic,urlString);
    [httpsManager postServerAPI:urlString deliveryDic:dataDic successful:^(id responseObject) {
        NSLog(@"responseObject===>%@",responseObject);
        
        
        if ([[(NSDictionary *)responseObject objectForKey:@"code"] integerValue] ==200) {
            
            NSDictionary *dataDic = [(NSDictionary *)responseObject objectForKey:@"data"];
            if ([[dataDic objectForKey:@"error_code"] integerValue] ==0){
                [SVHUD showSuccessWithDelay:@"提交成功!" time:0.8f blockAction:^{
                    [popView removeFromSuperview];
                }];
            }
            else
            {
                [self waring:@"提交失败!"];
            }
            
        }
        else
        {
            [self waring:@"提交失败!"];
        }
        
        
    } fail:^(id error) {
        [self waring:@"提交失败!"];
    }];

}

-(void)waring:(NSString *)string{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:string time:0.8];
    });
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    ReservationOrderModel *model = _dataArray[indexPath.section];
    if ([model.orderStatus integerValue] != 4) {
        OrderDetailViewController *vc = [OrderDetailViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idString  = model.orderId;
        vc.orderStatus = model.orderStatus;
        [self.navigationController.navigationController pushViewController:vc animated:YES];
    }

    
}

-(void)selectedIndex:(NSInteger)index{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] initWithCapacity:0];
    switch (index) {
        case 0:
        {
            [dic setObject:@"" forKey:@"status"];
                
        }
        break;
            
        case 1:
        {
            [dic setObject:@"1" forKey:@"status"];
            
        }
        break;
        case 2:
        {
            [dic setObject:@"2" forKey:@"status"];
            
        }
        break;
        case 3:
        {
            [dic setObject:@"4" forKey:@"status"];
            
        }
        break;
            
        default:
            break;
    }
    [self fetchData:dic];
    [_tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
