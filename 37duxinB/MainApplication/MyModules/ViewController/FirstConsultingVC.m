//
//  FirstConsultingVC.m
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "FirstConsultingVC.h"
#import "ApplyCommentCell.h"
#import "TextFieldCell.h"
#import "TitleWithItemCell.h"
#import "SelectTwiceCell.h"
#import "MyConsultingServiewVC.h"
#import "PopTagSelectView.h"
#import "PopBackgroundView.h"
#import "ServiceTagsCell.h"

@interface FirstConsultingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_titleArray;
    NSMutableArray *_infoArray;
    PackageModel *_model;
}
@end

@implementation FirstConsultingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)setmodel:(PackageModel *)model{
    
    _model = [[PackageModel alloc] init];
    _model.packageId = model.packageId;
    _model.packageTitle = model.packageTitle;
    
    NSDictionary *tagsDic = @{@"恋爱婚姻":@"1",@"职业发展":@"2",@"亲子教育":@"3",@"性心理":@"4",@"人际关系":@"5",@"个人成长":@"6",@"情绪压力":@"7",@"解梦":@"8",@"星座占卜":@"9"};
    __block NSString *tagsString =@"";
    NSArray *tagsArray = [model.packageServiceTags componentsSeparatedByString:@","];
    [tagsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (tagsString.length == 0) {
            tagsString = [NSString stringWithFormat:@"%@%@",tagsString,[tagsDic objectForKey:(NSString *)obj]];
        }
        else
        {
            tagsString = [ NSString stringWithFormat:@"%@,%@",tagsString,[tagsDic objectForKey:(NSString *)obj]];
            
        }
    }];
    _model.packageServiceTags = tagsString;

    __block NSString *chatType = @"";
    NSArray *array = [model.packageConsultationWay componentsSeparatedByString:@","];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isEqualToString:@"电话"]){
            if(chatType.length == 0){
                chatType = [NSString stringWithFormat:@"%@%@",chatType,@"0"];
                
            }
            else
            {
                chatType = [NSString stringWithFormat:@"%@,%@",chatType,@"0"];
            }
            
        }
        
        if([obj isEqualToString:@"文字"]){
            if(chatType.length == 0){
                chatType = [NSString stringWithFormat:@"%@%@",chatType,@"1"];
                
            }
            else
            {
                chatType = [NSString stringWithFormat:@"%@,%@",chatType,@"1"];
            }
            
        }
    }];
    
    _model.packageConsultationWay = chatType;
    _model.packageServiceSinglePrice = model.packageServiceSinglePrice;
    _model.packageServiceHours = model.packageServiceHours;
    _model.packageServiceTimes = model.packageServiceTimes;
    _model.packageServiceContent = model.packageServiceContent;

}

-(void)initData{
    _titleArray =@[@{@"title":@"咨询标题",@"palceHolder":@"请输入标题",@"arrowState":@"1",@"required":@"0",@"editable":@"1"},
                   @{@"title":@"咨询标签",@"palceHolder":@"请输入标签",@"arrowState":@"1",@"required":@"0"},
                   @{@"title":@"咨询方式",@"palceHolder":@"",@"arrowState":@"1",@"required":@"0",@"selectedbtn":@[@"电话",@"文字"]},
                   @{@"title":@"咨询时长",@"palceHolder":@"请输入时长",@"arrowState":@"1",@"required":@"0",@"item":@"分钟",@"editable":@"1"},
                   @{@"title":@"单次价格",@"palceHolder":@"请输入价格",@"arrowState":@"1",@"required":@"0",@"item":@"元",@"editable":@"1"},
                   @{@"title":@"服务描述",@"palceHolder":@"请输入服务描述...",@"arrowState":@"1",@"required":@"0"}];
    
    if (_isEdit)
    {
        
        _infoArray = [[NSMutableArray alloc] initWithObjects:_model.packageTitle,_model.packageServiceTags,_model.packageConsultationWay, [NSString stringWithFormat:@"%@",_model.packageServiceHours],[NSString stringWithFormat:@"%@",_model.packageServiceSinglePrice],_model.packageServiceContent, nil];
    }
    else
    {
        _infoArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"1",@"",@"",@"",nil];
    }
    
}

-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"初次咨询" rightImage:@"whiteLeftArrow"];
    
    _tableView  =[[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView),SIZE.width,SIZE.height-h(self.navView))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [self fetchFooter];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
}

-(UIView *)fetchFooter{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 140)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextStepBtn = [[UIButton alloc] initWithFrame:CGRectMake(35,30,SIZE.width-70,40)];
    nextStepBtn.backgroundColor = Color_5ECAF5;
    [nextStepBtn.layer setCornerRadius:2.0f];
    [nextStepBtn setTitle:@"发布服务" forState:UIControlStateNormal];
    [nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepBtn addTarget:self action:@selector(realseService:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextStepBtn];
    
    return view;
}

-(void)realseService:(UIButton *)button{
    
    NSLog(@"_infoArray==>%@",_infoArray);
    __block BOOL isFullFill = YES;
    [_infoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj==>~%@",[obj class]);
        NSString *string = [NSString stringWithFormat:@"%@",obj];
        if ([string isEqualToString:@""]) {
            NSDictionary *dic = _titleArray[idx];
            NSString *showTitle = [NSString stringWithFormat:@"请输入%@",dic[@"title"]];
            [SVHUD showErrorWithDelay:showTitle time:0.8f];
            isFullFill = NO;
            *stop = YES;
        }
    }];
    
    if (isFullFill) {
        [self releaseAdvice];
    }

    
}


-(void)releaseAdvice{
    [SVProgressHUD show];
    HttpsManager *manager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    __block NSString *urlString = @"";
    if (_isEdit)
    {
        urlString = [NSString stringWithFormat:@"%@%@",PostModifyReservationPackage,_model.packageId];
    }
    else
    {
        urlString =PostCreateReservationPackage;
        
    }
    [dic setObject:_infoArray[0] forKey:@"title"];
    [dic setObject:_infoArray[1] forKey:@"tags"];
    [dic setObject:_infoArray[2] forKey:@"consultation_way"];
    [dic setObject:_infoArray[3] forKey:@"service_hours"];
    [dic setObject:_infoArray[4] forKey:@"single_price"];
    [dic setObject:_infoArray[5] forKey:@"service_content"];
    [dic setObject:@"1" forKey:@"service_times"];
    [dic setObject:@"0" forKey:@"service_type"];
    [manager postServerAPI:urlString deliveryDic:dic successful:^(id responseObject) {
        
        NSLog(@"responseObject===>%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"] integerValue]== 200) {
            
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            
            if ([[[responseDic objectForKey:@"data"] objectForKey:@"error_code"] integerValue] == 0) {
                [SVHUD showSuccessWithDelay:_isEdit?@"修改任务成功！":@"发布任务成功！" time:0.8f blockAction:^{
                    
                    __block NSInteger index;
                    if (_isEdit) {
                         index = self.navigationController.viewControllers.count-2;
                    }
                    else{
                        index = self.navigationController.viewControllers.count-3;
                    }
                    MyConsultingServiewVC *vc = self.navigationController.viewControllers[index];
                    [self.navigationController popToViewController:vc  animated:YES];
                    
                }];
                
            }
            else{
                
                [SVHUD showErrorWithDelay:[[responseDic objectForKey:@"data"] objectForKey:@"msg"] time:0.8f];
                
            }
        }
        
    } fail:^(id error) {
        [SVHUD showErrorWithDelay:_isEdit?@"修改任务失败！":@"发布任务失败！" time:0.8f];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = 0.001f;
    if (indexPath.row == _titleArray.count-1) {
        cellHeight = 225.0f;
    }
    else
    {
        cellHeight = 53.0f;
    }
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = _titleArray[indexPath.row];
    if (indexPath.row ==_titleArray.count-1)
    {
        static NSString *commentCellID = @"CommentCellID";
        ApplyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
        if (cell == nil) {
            cell = [[ApplyCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.tag = indexPath.row;
        if (![_infoArray[indexPath.row] isEqualToString:@""]) {
            cell.commentTextView.text = _infoArray[indexPath.row];
        }
        cell.lineView.hidden = YES;
        cell.sampleBtn.hidden = YES;
        cell.textChangeBlock = ^(NSString *text, NSInteger tag) {
          
            [_infoArray replaceObjectAtIndex:tag withObject:text];
            NSLog(@"_infoArray==>%@",_infoArray);
        };
        [cell updateUI:dic];
        return cell;
        
    }
    else
        if (indexPath.row ==1) {
            
            static NSString *serviceTagsCellID = @"ServiceTagsCell";
            ServiceTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceTagsCellID];
            if (cell == nil) {
                cell = [[ServiceTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:serviceTagsCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            [cell updateUI:dic];
            [cell drawTags:_infoArray[1]];
            return cell;
        }
    else
        if(indexPath.row ==2)
        {
            static NSString *selectTwiceCellID = @"SelectTwiceCell";
            SelectTwiceCell *cell = [tableView dequeueReusableCellWithIdentifier:selectTwiceCellID];
            if (cell == nil) {
                cell = [[SelectTwiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectTwiceCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            [cell setSelectedData:_infoArray[2]];
            [cell updateUI:dic];
            cell.selectedTypeBlock = ^(NSString *tag) {
                [_infoArray replaceObjectAtIndex:2 withObject:tag];
                [_tableView reloadData];
            };
            return cell;
        }
        else
            if(indexPath.row == 3 ||indexPath.row == 4)
            {
                
                static NSString *textFieldCellID = @"textFieldCell";
                TitleWithItemCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
                if (cell == nil) {
                    cell = [[TitleWithItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.tag = indexPath.row;
                cell.textFild.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                NSString *string = [NSString stringWithFormat:@"%@",_infoArray[cell.tag]];
                cell.textFild.text = string;
               
                cell.textFieldBlock = ^(UITextField *textField) {
                 
                    [_infoArray replaceObjectAtIndex:textField.tag withObject:textField.text];
                    NSLog(@"%@",_infoArray);
                };
                [cell updateUI:dic];
                return cell;
                
                
            }
            else
            {
                
                static NSString *textFieldCellID = @"textFieldCell";
                TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
                if (cell == nil) {
                    cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                cell.tag = indexPath.row;
                
                if (![_infoArray[indexPath.row] isEqualToString:@""]) {
                    cell.textFild.text = _infoArray[indexPath.row];
                }
               
                cell.textFieldBlock = ^(UITextField *textField) {
                    [_infoArray replaceObjectAtIndex:textField.tag withObject:textField.text];
                };
                [cell updateUI:dic];
                return cell;
                
            }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        PopTagSelectView *view = [[PopTagSelectView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width-46, 300)];
        view.limitTags = 3;
        PopBackgroundView *backgroundView = [[PopBackgroundView  alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height) withPopView:view];
        __weak typeof(backgroundView) weakBackgroundView = backgroundView;
        backgroundView.confrimBlock = ^(NSDictionary *dic) {
            
            [_infoArray  replaceObjectAtIndex:1 withObject:dic[@"tags"]];
            [_tableView reloadData];
            [weakBackgroundView removeFromSuperview];
            
        };
        
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
