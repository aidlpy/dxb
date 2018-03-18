//
//  BackgroundViewController.m
//  37duxinB
//
//  Created by 37duxin on 05/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "BackgroundViewController.h"
#import "TextFieldCell.h"
#import "SelectedSinglePhotoCell.h"
#import "SelectedImageCell.h"
#import "SelectedPhotosCell.h"
#import "ApplyCommentCell.h"
#import "LoginViewController.h"
#import "PopTagSelectView.h"
#import "PopBackgroundView.h"
#import "ServiceTagsCell.h"
#import "TextFieldRightBtnCell.h"

@interface BackgroundViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDelegate>
{
    UITableView *_tableView;
    NSArray *_titleArray;
    NSMutableArray *_infoArray0;
    NSMutableArray *_infoArray1;
    CGFloat _tagRowHeight;
}
@end

static NSString *tranningBackGround = @"受训背景\n美国NGH催眠师，师从台湾催眠师唐道德\n萨提亚治疗室，师从马来西亚林文采\n精通情绪治疗室，师从美国汤姆.斯通\n全环境生命教育教练技术导师，师从中国边疆导师\nNLP执行师，师从台湾唐道德，凌坤贞\n隐喻治疗室，师从台湾邱丽娃\n心教练治疗师，师从台湾阮惠习\n教练之道导师，师从香港黄米兰";
static NSString *workingBackGround = @"执业背景\n原上海德瑞姆心理学院院长，主任咨询师\n上海高校咨询小组领队\n背景华教国际副总裁，导师\n宇君教育副总裁，首席导师";
static NSString *strengthArea = @"擅长领域\n亲子关系提升与修复，亲密关系提升与修复，职业发展与规划，自我觉醒与蜕变，幸福指数提升，人际关系提升与完善，沟通技巧提升，非权力性影响力和领导力提升";
static NSString *consultingStyle = @"咨询风格\n亲和 包容 睿智 敏锐 热诚\n擅长亲子关系中学习、沟通及情感等问题的咨询，具有20多年的心理咨询经历，累计个案咨询时间4000多个小时，培训及督导了1600多名心理咨询师，主要以精神分析（心理动力学）取向为基础，整合系统家庭治疗，融合认知行为疗法、人本主义技术等融会贯通，以适合来访者的需要为中心。";

static NSString *personaTagsDetail = @"个人标签会展示在您的主页，可以帮助用户更准确地找到您进行咨询哦~\n在文本框中输入文字，以空格键区分，一个标签不得超过5个字，最多可输入3个标签。\n示例标签：婚恋情感专家，高级情感分析师，个人成长，国际催眠，亲子关系，家庭教育";

@implementation BackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

-(void)initData{

    _titleArray =@[@[@{@"title":@"资质名称",@"palceHolder":@"请选择",@"arrowState":@"1",@"required":@"0"},
                       @{@"title":@"资质编号",@"palceHolder":@"请输入资质编号",@"arrowState":@"1",@"editable":@"1",@"required":@"0"},
                       @{@"title":@"资质证明",@"palceHolder":@"",@"arrowState":@"0",@"required":@"0"},
                       @{@"title":@"从业年限",@"palceHolder":@"请输入从业年限",@"arrowState":@"1",@"editable":@"1",@"required":@"0"},
                       @{@"title":@"累计个案",@"palceHolder":@"请输入累计个案时长(小时)",@"arrowState":@"0",@"editable":@"1",@"required":@"0"}]
                   ,
                   @[@{@"title":@"咨询类别",@"palceHolder":@"请选择类别",@"arrowState":@"1",@"required":@"1"},
                     @{@"title":@"个人便签",@"palceHolder":@"请选择个标签",@"arrowState":@"0",@"editable":@"1",@"required":@"1"},
                     @{@"title":@"受训背景",@"required":@"0"},
                     @{@"title":@"执业背景",@"required":@"0"},
                     @{@"title":@"擅长领域",@"required":@"0"},
                     @{@"title":@"咨询风格",@"required":@"0"}]];
    _infoArray0 = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",nil];
    _infoArray1 = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",nil];
    
    _tagRowHeight = 53.0f;
}

-(void)initUI{

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navView setBackStytle:@"申请入驻" rightImage:@"whiteLeftArrow"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,h(self.navView), SIZE.width, SIZE.height-h(self.navView)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.tableHeaderView = [self fetchImageView];
    _tableView.tableFooterView = [self fetchFooter];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section ==0) {
        return  0.001f;
    }
    else
    {
        return 0.001f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 7.5f;
    }
    else
    {
        return 0.001f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =[UIColor whiteColor];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =Color_F1F1F1;
    return view;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = _titleArray[section];
    
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellHeight = 0.001f;
    if(indexPath.section == 0){
        
        if (indexPath.row == 2) {
           cellHeight =  76.5f;
        }
        else
        {
            cellHeight = 53.0f;
        }
        
    }
    else
    {
        
        if (indexPath.row ==0 ) {
            cellHeight = _tagRowHeight;
        }
        else if(indexPath.row == 1){
            cellHeight  = 53;
        }
        else
        {
            cellHeight = 225.0f;
        }
        
    }
    return cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *array = _titleArray[indexPath.section];
    NSDictionary *dic =array[indexPath.row];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 2) {
            
            static NSString *SelectedSinglePhotoCellID = @"selectedSinglePhotoCellID";
            SelectedSinglePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectedSinglePhotoCellID];
            if (cell == nil) {
                cell = [[SelectedSinglePhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SelectedSinglePhotoCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            cell.photoSelectionBlock = ^(BOOL isLeft, NSInteger tag) {
                [self showActionSheet];
            };
            [cell updateUI:dic];
            if (![[_infoArray0 objectAtIndex:indexPath.row] isEqualToString:@""]) {
                [cell.leftBtn sd_setImageWithURL:[NSURL URLWithString:[_infoArray0 objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
            }
            return cell;
            
        }
        else{
            
            static NSString *textFieldCellID = @"textFieldCellID";
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellID];
            if (cell == nil) {
                cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            [cell updateUI:dic];
            cell.textFieldBlock = ^(UITextField *textField) {
                [_infoArray0 replaceObjectAtIndex:textField.tag withObject:textField.text];
            };
            
            if (![[_infoArray0 objectAtIndex:indexPath.row] isEqualToString:@""]) {
                
                if (indexPath.row == 0) {
                    NSString *cerlevel = [_infoArray0 objectAtIndex:0];
                    if ([cerlevel isEqualToString:@"0"]) {
                        cell.textFild.text = @"精神科医生";
                    }
                    else
                    if ([cerlevel isEqualToString:@"1"]) {
                        cell.textFild.text = @"心理治疗师";
                    }
                    else
                    if ([cerlevel isEqualToString:@"2"]) {
                        cell.textFild.text = @"国家婚姻家庭咨询师";
                    }
                    else
                    if ([cerlevel isEqualToString:@"3"]) {
                        cell.textFild.text = @"国家二级心理咨询师";
                    }
                    else
                    {
                        cell.textFild.text = @"国家三级心理咨询师";
                        
                    }
                }
                
            }
            
            return cell;
            
        }
    }
    else
    {
        if (indexPath.row == 1) {
            
            static NSString *textFieldCellRIGHTBTNID = @"textFieldCellRIGHTBTNID";
            TextFieldRightBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:textFieldCellRIGHTBTNID];
            if (cell == nil) {
                cell = [[TextFieldRightBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textFieldCellRIGHTBTNID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            cell.textFieldBlock = ^(UITextField *textField) {
                [_infoArray1 replaceObjectAtIndex:1 withObject:textField.text];
                
            };
            cell.showDeailBlock = ^{
                __block NSString *_infoString =personaTagsDetail;
                __block NSString *_alertTitle =@"帮助";
                
                [AAlertView alertWithTitle:_alertTitle controller:self message:_infoString confirm:^{
                    
                } completion:^{
                    
                }];
            };
            [cell updateUI:dic];
            return cell;
            
        }
        else if(indexPath.row == 0){
            
            static NSString *serviceTagsCellID = @"ServiceTagsCell";
            ServiceTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceTagsCellID];
            if (cell == nil) {
                cell = [[ServiceTagsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:serviceTagsCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            [cell updateUI:dic];
            [cell drawTags:_infoArray1[0]];
            [cell.lineView setMj_y:_tagRowHeight-1];
            return cell;
            
            
        }
        else
        {
            static NSString *commentCellID = @"CommentCellID";
            ApplyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
            if (cell == nil) {
                cell = [[ApplyCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = indexPath.row;
            cell.textChangeBlock = ^(NSString *text, NSInteger tag) {
                [_infoArray1 replaceObjectAtIndex:tag withObject:text];
            };
            cell.showExampleBlock = ^(NSInteger tag) {
                __block NSString *_infoString = @"";
                __block NSString *_alertTitle =@"示例描述";
                switch (tag) {
                    case 2:
                    {
                        _infoString = tranningBackGround;
                        //_alertTitle = @"受训背景";

                    }
                        break;
                    case 3:
                    {
                        _infoString = workingBackGround;
                        //_alertTitle = @"执业背景";
                    }
                        break;
                    case 4:
                    {
                        _infoString = strengthArea;
                        //_alertTitle = @"擅长领域";
                    }
                        break;
                    case 5:
                    {
                        _infoString = consultingStyle;
                        //_alertTitle = @"咨询风格";
                    }
                        break;
                        
                    default:
                        break;
                }
                [AAlertView alertWithTitle:_alertTitle controller:self message:_infoString confirm:^{

                } completion:^{

                }];
              
                
            };
            [cell updateUI:dic];
            return cell;
            
        }
        
        
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                [self showCerLevelAction];
            }
                break;
            case 2:
            {
                
            }
                break;
            case 5:
            {
                
            }
                break;
                
            default:
                break;
        }
        
    }
    else{
        
        switch (indexPath.row) {
            case 0:
                {
                    PopTagSelectView *view = [[PopTagSelectView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width-46, 300)];
                    view.limitTags = 9;
                    PopBackgroundView *backgroundView = [[PopBackgroundView  alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height) withPopView:view];
                    
                    __weak typeof(backgroundView) weakBackgroundView = backgroundView;
                    backgroundView.confrimBlock = ^(NSDictionary *dic) {
                        _tagRowHeight = [dic[@"rowHeight"] integerValue];
                        [_infoArray1  replaceObjectAtIndex:0 withObject:dic[@"tags"]];
                        [_tableView reloadData];
                        [weakBackgroundView removeFromSuperview];
                    };
                    
                
                }
                break;
            case 1:
            {
                
            }
                break;
            default:
                break;
        }
    }
   
    
}

-(UIView *)fetchFooter{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 170)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextStepBtn = [[UIButton alloc] initWithFrame:CGRectMake(35,30,SIZE.width-70,40)];
    nextStepBtn.backgroundColor = Color_5ECAF5;
    [nextStepBtn.layer setCornerRadius:2.0f];
    [nextStepBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextStepBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextStepBtn];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(35,bottom(nextStepBtn)+20,SIZE.width-70,40)];
    backBtn.backgroundColor = Color_5ECAF5;
    [backBtn.layer setCornerRadius:2.0f];
    [backBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    
    return view;
}

-(void)nextStepAction:(UIButton *)sender{
    [SVProgressHUD show];
    
    __block BOOL _isOkay = YES;
    NSArray *array0 =_titleArray[0];
    NSArray *array1 =_titleArray[1];

  
        NSString *string0 = _infoArray1[0];
        if ([string0 isEqualToString:@""])
        {
            [SVHUD showErrorWithDelay:@"请选择咨询类别" time:0.8];
            return;
        }

        NSString *string1 = _infoArray1[1];
        if ([string1 isEqualToString:@""]) {
            [SVHUD showErrorWithDelay:@"请输入个人标签" time:0.8];
            return;
        }
        
        if (_isOkay) {
            NSString *string1 = _infoArray1[1];
            __block NSInteger count = 0;
            __block NSString *tagsString = [[NSMutableString alloc] initWithCapacity:0];
            NSArray *tagsArray = [string1 componentsSeparatedByString:@" "];
            [tagsArray enumerateObjectsUsingBlock:^(id  _Nonnull subobj, NSUInteger subidx, BOOL * _Nonnull stop) {
                if ([subobj isEqualToString:@""] == NO) {
                    if (((NSString *)subobj).length > 5) {
                        [SVHUD showErrorWithDelay:@"标签长度不可以超过5个字" time:0.8];
                        _isOkay = NO;
                        *stop = YES;
                    }
                    count++;
                    if (subidx == 0) {
                        tagsString = [NSString stringWithFormat:@"%@%@",tagsString,subobj];
                    }
                    else
                    {
                        tagsString = [NSString stringWithFormat:@"%@,%@",tagsString,subobj];
                    }
                    
                }
                
                if (count >3) {
                    
                    [SVHUD showErrorWithDelay:@"标签不可以超过3个" time:0.8];
                    _isOkay = NO;
                    *stop = YES;
                }
                
            }];
            [_infoArray1 replaceObjectAtIndex:1 withObject:tagsString];
            
        }
  
       

    if (_isOkay) {
        HttpsManager *httpsManager = [HttpsManager new];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:_usernameString forKey:@"username"];
        [dic setObject:_infoArray0[0] forKey:@"qualified_name"];
        [dic setObject:_infoArray0[1] forKey:@"qualified_no"];
        [dic setObject:_infoArray0[2] forKey:@"qualified_cert"];
        [dic setObject:_infoArray0[3] forKey:@"working_years"];
        [dic setObject:_infoArray0[4] forKey:@"cumulative_time"];
        
        //由“,”转为“|”为分割符号
        NSString *serviceType = _infoArray1[0];
        NSArray *serviceTypeArray = [serviceType componentsSeparatedByString:@","];
        __block NSString *newServiceType = @"";
        [serviceTypeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0)
            {
                newServiceType = [NSString stringWithFormat:@"%@",obj];
            }
            else
            {
                newServiceType = [NSString stringWithFormat:@"%@|%@",newServiceType,obj];
            }
        }];
        [dic setObject:newServiceType forKey:@"service_type"];
        
        [dic setObject:_infoArray1[1] forKey:@"tags"];
        [dic setObject:_infoArray1[2] forKey:@"trained_background"];
        [dic setObject:_infoArray1[3] forKey:@"professional_background"];
        [dic setObject:_infoArray1[4] forKey:@"expertise_good"];
        [dic setObject:_infoArray1[5] forKey:@"advisory_style"];
        
        [httpsManager postServerAPI:PostBbackGround deliveryDic:dic successful:^(id responseObject) {
            [SVProgressHUD dismiss];
            if ([[responseObject objectForKey:@"code"] integerValue] ==200) {
                NSDictionary *dataDic = [responseObject objectForKey:@"data"];
                if ([[dataDic objectForKey:@"error_code"] integerValue]== 0) {
                    [SVHUD showSuccessWithDelay:@"从业背景信息提交成功！" time:0.8f blockAction:^{
                        LoginViewController *vc = [LoginViewController new];
                        [self.navigationController pushViewController:vc animated:YES];
                    }];
                }
            }
        } fail:^(id error) {
            [SVHUD showErrorWithDelay:@"网络请求失败" time:0.8];
        }];
    }

    
    
}

-(void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UIView  *)fetchImageView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width,85)];
    view.backgroundColor = Color_F1F1F1;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 80)];
    imageView.backgroundColor = [UIColor whiteColor];
    [imageView setImage:[UIImage imageNamed:Image(@"step_2")]];
    [view addSubview:imageView];
    
    return  view;
    
}

-(void)showCerLevelAction{
    
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *primaraySchoolAction = [UIAlertAction actionWithTitle:@"精神科医生" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray0 replaceObjectAtIndex:0 withObject:@"0"];
        [_tableView reloadData];
    }];
    UIAlertAction *generalSchoolAction = [UIAlertAction actionWithTitle:@"心理治疗师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray0 replaceObjectAtIndex:0 withObject:@"1"];
        [_tableView reloadData];
    }];
    UIAlertAction *hightSchool = [UIAlertAction actionWithTitle:@"国家婚姻家庭咨询师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray0 replaceObjectAtIndex:0 withObject:@"2"];
        [_tableView reloadData];
    }];
    UIAlertAction *diplomaSchoolAction = [UIAlertAction actionWithTitle:@"国家二级心理咨询师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray0 replaceObjectAtIndex:0 withObject:@"3"];
        [_tableView reloadData];
    }];
    UIAlertAction *bachoreSchoolAction = [UIAlertAction actionWithTitle:@"国家三级心理咨询师" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_infoArray0 replaceObjectAtIndex:0 withObject:@"4"];
        [_tableView reloadData];
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:primaraySchoolAction];
    [AlertSelect addAction:generalSchoolAction];
    [AlertSelect addAction:hightSchool];
    [AlertSelect addAction:diplomaSchoolAction];
    [AlertSelect addAction:bachoreSchoolAction];
    [AlertSelect addAction:cancelAction];
    [self presentViewController:AlertSelect animated:YES completion:nil];
}

-(void)showActionSheet
{
    UIAlertController *AlertSelect = [UIAlertController new];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self localPhoto];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [AlertSelect addAction:camera];
    [AlertSelect addAction:photo];
    [AlertSelect addAction:cancelAction];
    
    [self presentViewController:AlertSelect animated:YES completion:nil];
    
}

-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        
    {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:NO completion:nil];
        
    }
    else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


-(void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //先把图片转成NSData
            UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            NSData *yadata =UIImageJPEGRepresentation(image,0.6f);
            [self postPhoto:yadata];
        });
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)postPhoto:(NSData *)data{
    
    HttpsManager *httpsManager = [[HttpsManager alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:@"type"];
    [httpsManager postServerAPI:postImageURL Paramater:dic data:data name:@"touxiang.jpg" andContentType:@"image/jpeg" successful:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([[dic objectForKey:@"code"] integerValue] ==200) {
            
            NSDictionary *dataDic = [dic objectForKey:@"data"];
            
            if ([[dataDic objectForKey:@"code"] integerValue] == 0) {
                
                NSString *url = [dataDic objectForKey:@"url"];
                NSMutableString *mutableString = [NSMutableString stringWithString:url];
                NSString *currentString = [mutableString stringByReplacingOccurrencesOfString:@"-internal" withString:@""];
                [_infoArray0 replaceObjectAtIndex:2 withObject:currentString];
   

                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
            }
            else{
                [self errorwarning];
            }
        }
        
    } fail:^(id error) {
        
        [self errorwarning];
    }];
}

-(void)errorwarning{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVHUD showErrorWithDelay:@"选择照片失败" time:0.8];
    });
    
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
