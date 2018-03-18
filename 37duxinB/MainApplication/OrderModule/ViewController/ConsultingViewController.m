//
//  ConsultingViewController.m
//  37duxinB
//
//  Created by 37duxin on 06/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ConsultingViewController.h"
#import "DeepConsultingCell.h"
#import "DeepConsultingTypeOneCell.h"
#import "DeepWatingForConsultingCell.h"
#import "DeepCheckCommentCell.h"
#import "OrderViewController.h"
#import "OrderTitleView.h"
#import "ConsultingOrderModel.h"
#import "ConsultingSubOrderModel.h"
#import "JumpModel.h"
#import "ConsultingMainOrderFinishDetailViewController.h"

@interface ConsultingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     OrderTitleView  *_titleView;
     UITableView *_tableView;
     NSMutableArray *_dataArray;
     BOOL _isHeaderFresh;
    JumpModel *_model;
}
@end

@implementation ConsultingViewController

-(void)fetchData:(NSMutableDictionary *)dic{
    if (_isHeaderFresh)
    {
        [_dataArray removeAllObjects];
    }

    HttpsManager *httpManager  = [HttpsManager new];
    [httpManager getServerAPI:_model.url deliveryDic:dic successful:^(id responseObject) {
        
         dispatch_async(dispatch_get_global_queue(0, 0), ^{
             
             if ([[responseObject objectForKey:@"code"] integerValue] == 200)
             {
                 NSDictionary *dataDic = (NSDictionary *)responseObject;
                 NSDictionary *reusltDic = [dataDic objectForKey:@"data"];
                 NSArray  *array = [reusltDic objectForKey:@"result"];
           
                 
                 if (array.count != 0) {
                     
                     if (_model.isMain)
                     {
                         [ConsultingOrderModel fetchArray:array model:^(BOOL stop, ConsultingOrderModel *model) {
                             [_dataArray addObject:model];
                             if (stop) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [_tableView reloadData];
                                     _isHeaderFresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer endRefreshing];
                                 });
                             }
                             
                         }];
                         
                     }
                     else
                     {
                        
                         [ConsultingSubOrderModel fetchArray:array model:^(BOOL stop, ConsultingSubOrderModel *model) {
                             [_dataArray addObject:model];
                             if (stop) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [_tableView reloadData];
                                     _isHeaderFresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer endRefreshing];
                                 });
                             }
                             
                         }];
                     }
                     
                 }
                 else
                 {
                     [self reloadNonData];
                 }
       
                 
             }
             else
             {
                 [self waring];
             }
             
         });
        
    } fail:^(id error) {
         [self waring];
    }];
}

-(void)waring{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD  showErrorWithDelay:@"获取订单失败" time:0.8];
    });
}

-(void)reloadNonData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD  showErrorWithDelay:@"无数据" time:0.8];
        [_tableView reloadData];
        _isHeaderFresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer endRefreshing];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _model = [JumpModel new];
    [self selectedIndex:0];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}


-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0,Height_NavBar+50,SIZE.width, 50) withArray:@[@"全部",@"待支付",@"待咨询",@"待评价",@"已评价",@"已完成"]];
    _titleView.indexBlock = ^(NSInteger index) {
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_titleView];
    
    [_titleView.btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        btn.titleLabel.font = FONT_13;
    }];
    
    
    CGFloat tabbarHeight = Height_TabBar;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,bottom(_titleView),SIZE.width,SIZE.height-bottom(_titleView)-tabbarHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _isHeaderFresh = YES;
    }];

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
    
    if (_model.isMain == NO) {
   
        ConsultingSubOrderModel *model = _dataArray[indexPath.section];
        if ([model.orderSubStatus integerValue] == 1 ||[model.orderSubStatus integerValue] == 2) {
            return 170.0f;
        }
        else
        {
            return 210.0f;
        }
        
    }
    else
    {
        return 210.0f;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_model.isMain) {
        
        ConsultingOrderModel *model = _dataArray[indexPath.section];
        if ([model.orderStatus integerValue] == 0 || [model.orderStatus integerValue] == 4 ) {
            static NSString *DeepConsultingCellID = @"DeepConsultingCellID";
            DeepConsultingCell *cell = [tableView dequeueReusableCellWithIdentifier:DeepConsultingCellID];
            if (cell == nil) {
                cell = [[DeepConsultingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeepConsultingCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            [cell updateUI:model];
            return cell;
        }
        else
        {
            static NSString *DeepConsultingTypeOneCellID = @"DeepConsultingTypeOneCellID";
            DeepConsultingTypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:DeepConsultingTypeOneCellID];
            if (cell == nil) {
                cell = [[DeepConsultingTypeOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeepConsultingTypeOneCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            return cell;
            
        }
        
    }
    else
    {
        
        ConsultingSubOrderModel *model = _dataArray[indexPath.section];
        if ([model.orderSubStatus integerValue] == 2)
        {
            static NSString *DeepCheckCommentCellID = @"DeepCheckCommentCellID";
            DeepCheckCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:DeepCheckCommentCellID];
            if (cell == nil) {
                cell = [[DeepCheckCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeepCheckCommentCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.tag = indexPath.row;
                [cell updateUI:model];
                return cell;
                
            }
            else
            {
                static NSString *DeepWatingForConsultingCellID = @"DeepWatingForConsultingCellID";
                DeepWatingForConsultingCell *cell = [tableView dequeueReusableCellWithIdentifier:DeepWatingForConsultingCellID];
                if (cell == nil) {
                    cell = [[DeepWatingForConsultingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeepWatingForConsultingCellID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                cell.tag = indexPath.row;
                [cell updateUI:model];
                return cell;
                
            }
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_model.isMain == YES) {
        
        ConsultingOrderModel *model = _dataArray[indexPath.section];
        
        if ([model.orderStatus isEqualToString:@"0"]) {
            ConsultingMainOrderFinishDetailViewController *vc = [ConsultingMainOrderFinishDetailViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.idString = model.orderId;
            vc.isMain = _model.isMain;
            vc.orderStatus = model.orderStatus;
            [self.navigationController.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            ConsultingMainOrderFinishDetailViewController *vc = [ConsultingMainOrderFinishDetailViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            vc.idString = model.orderId;
            vc.isMain = _model.isMain;
            [self.navigationController.navigationController pushViewController:vc animated:YES];
            
        }
         
    }
    else{
        
        ConsultingSubOrderModel *model = _dataArray[indexPath.section];
        if ([model.orderSubStatus isEqualToString:@"0"])
        {
            
        }
        else
        if ([model.orderSubStatus isEqualToString:@"1"])
        {
            
        }
        else
        {
            
            
        }
        
    }
    
}

-(void)selectedIndex:(NSInteger)index{
    _isHeaderFresh = YES;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    switch (index) {
        case 0:
        {
            [dic setObject:@"" forKey:@"status"];
            _model.url =  FetchBConsultingOrders;
            _model.isMain = YES;
            _model.status = @"";
        }
            break;
        case 1:
        {
            [dic setObject:@"0" forKey:@"status"];
            _model.url = FetchBConsultingOrders;
            _model.isMain = YES;
            _model.status = @"0";
        }
            break;
        case 2:
        {
            [dic setObject:@"0" forKey:@"sub_status"];
            _model.url = FetchBConsultingSubOrders;
            _model.isMain = NO;
            _model.status = @"0";
        }
            break;
        case 3:
        {
             [dic setObject:@"1" forKey:@"sub_status"];
            _model.url = FetchBConsultingSubOrders;
            _model.isMain = NO;
            _model.status = @"1";
        }
            break;
        case 4:
        {
             [dic setObject:@"2" forKey:@"sub_status"];
            _model.url = FetchBConsultingSubOrders;
            _model.isMain = NO;
            _model.status = @"2";
        }
            break;
        case 5:
        {
             [dic setObject:@"4" forKey:@"status"];
             _model.url = FetchBConsultingOrders;
             _model.isMain = YES;
            _model.status = @"4";
        }
            break;
            
        default:
            break;
    }
    [_tableView.mj_header beginRefreshing];
    [self fetchData:dic];
    
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
