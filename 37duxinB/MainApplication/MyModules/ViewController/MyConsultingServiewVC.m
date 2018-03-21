//
//  MyConsultingServiewVC.m
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "MyConsultingServiewVC.h"
#import "ServiceSelectedVC.h"
#import "OrderTitleView.h"
#import "MyServiceCell.h"
#import "PackageModel.h"
#import "MyServiceTypeTwoCell.h"
#import "FirstConsultingVC.h"
#import "DeepConsultingVC.h"

@interface MyConsultingServiewVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    OrderTitleView *_titleView;
    BOOL _isHeaderFresh;
    NSString *_orderType;
    
}
@end

@implementation MyConsultingServiewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    _orderType = @"0";
    _isHeaderFresh = YES;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView.mj_header beginRefreshing];
    
}


-(void)fetchData{
    HttpsManager *httpManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:_orderType forKey:@"service_type"];
    [httpManager getServerAPI:FetchServicePackageData deliveryDic:dic successful:^(id responseObject) {
        NSLog(@"responseObject==>%@",responseObject);
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        if ([[responseDic objectForKey:@"code"]  integerValue] == 200) {
            
            NSArray *resultArray = [[responseDic objectForKey:@"data"] objectForKey:@"result"];
            if (_isHeaderFresh) {
                [_dataArray removeAllObjects];
            }
            
            if (resultArray.count == 0)
            {
                [_tableView reloadData];
                _isHeaderFresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer  endRefreshing];
            }
            else
            {
                [PackageModel fetchArray:resultArray model:^(BOOL stop, PackageModel *model) {
                    [_dataArray addObject:model];
                    
                    if (stop)
                    {
                        [_tableView reloadData];
                        _isHeaderFresh?[_tableView.mj_header endRefreshing]:[_tableView.mj_footer  endRefreshing];
                    }
                    
                }];
                
            }
     
            
        }
        
    } fail:^(id error) {
        
    }];
    
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"咨询服务" rightImage:@"whiteLeftArrow"];
    
    __weak typeof(self) weakSelf = self;
    _titleView = [[OrderTitleView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, 50) withArray:@[@"初次咨询",@"深度咨询"]];
    _titleView.indexBlock = ^(NSInteger index) {
        [weakSelf selectedIndex:index];
    };
    [self.view addSubview:_titleView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, h(self.navView)+h(_titleView), SIZE.width,SIZE.height-bottom(_titleView))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData];
    }];
    [self customView];
    [self.view addSubview:_tableView];
    
    [_tableView.mj_header beginRefreshing];
    
    UIButton *addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0,SIZE.height-110, 80, 80)];
    addBtn.center  = CGPointMake(SIZE.width/2,addBtn.center.y);
    [addBtn setImage:[UIImage imageNamed:Image(@"myAddBtn")] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

-(void)selectedIndex:(NSInteger)tag{
    
    switch (tag) {
        case 0:
        {
            _orderType = @"0";
            [_tableView.mj_header beginRefreshing];
        }
            break;
            
        case 1:
        {
            _orderType = @"1";
            [_tableView.mj_header beginRefreshing];
            
        }
            break;
            
        default:
            break;
    }
    
    
}


-(void)customView{
    
    //初始化一个emptyView
    LYEmptyView *emptyView = [LYEmptyView emptyActionViewWithImageStr:Image(@"noServiceLogo")
                                                             titleStr:@"您还未发布任何服务"
                                                            detailStr:@""
                                                          btnTitleStr:@""
                                                        btnClickBlock:^{}];
    //元素竖直方向的间距
    emptyView.contentViewY = 180.0f;
    emptyView.titleLabTextColor = Color_BABABA;
    emptyView.titleLabFont = FONT_13;
    //设置空内容占位图
    _tableView.ly_emptyView = emptyView;
    
}


-(void)addBtnAction:(UIButton *)sender{
    
    ServiceSelectedVC *vc = [ServiceSelectedVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PackageModel *model = _dataArray[indexPath.row];
    return model.cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

// 移动 cell 时触发
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 移动cell之后更换数据数组里的循序
    [_dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PackageModel *model = _dataArray[indexPath.row];
    
    if ([model.packageServiceType integerValue] == 0) {
       
        static NSString *myServiceTypeOneCellID = @"myServiceTypeOneCell";
        MyServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:myServiceTypeOneCellID];
        if (cell == nil) {
            cell = [[MyServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myServiceTypeOneCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        [cell updateUI:model];
        return cell;
        
    }
    else
    {
        static NSString *myServiceTypeTwoID = @"myServiceTypeTwoCell";
        MyServiceTypeTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:myServiceTypeTwoID];
        if (cell == nil) {
            cell = [[MyServiceTypeTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myServiceTypeTwoID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        [cell updateUI:model];
        return cell;
    
    }

    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PackageModel *model = _dataArray[indexPath.row];
    if ([model.packageServiceType integerValue] == 0) {
        
        FirstConsultingVC *vc= [FirstConsultingVC new];
        vc.hidesBottomBarWhenPushed  = YES;
        vc.isEdit = YES;
        [vc setmodel:model];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        DeepConsultingVC *vc = [DeepConsultingVC new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isEdit = YES;
        [vc setmodel:model];
        [self.navigationController  pushViewController:vc animated:YES];
        
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return   UITableViewCellEditingStyleDelete;
    
}

/*改变删除按钮的title*/

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return @"删除";
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        
        PackageModel *model = _dataArray[indexPath.row];
        HttpsManager *httpsManager = [HttpsManager new];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString *urlString = [NSString stringWithFormat:@"%@%@",PostDeleteServicePackage,model.packageId];
        [httpsManager postServerAPI:urlString deliveryDic:dic successful:^(id responseObject) {
            
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            if ([[responseDic objectForKey:@"code"] integerValue] ==200)
            {
                 NSString *error_code = [[responseDic objectForKey:@"data"] objectForKey:@"error_code"];
                if ([error_code integerValue] == 0) {
                    
                    [_dataArray removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
                    [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];  //删除对应数据的cell
                    [SVHUD showSuccessWithDelay:[[responseDic objectForKey:@"data"] objectForKey:@"msg"] time:0.8f];
                }
                else
                {
                    [SVHUD showErrorWithDelay:[[responseDic objectForKey:@"data"] objectForKey:@"msg"] time:0.8f];
                }
            }
                
        } fail:^(id error) {
             [SVHUD showErrorWithDelay:@"请求数据失败！" time:0.8f];
        }];

    
        
    }
    
}


-(void)backTo{
    [self.navigationController popViewControllerAnimated:YES];
    
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
