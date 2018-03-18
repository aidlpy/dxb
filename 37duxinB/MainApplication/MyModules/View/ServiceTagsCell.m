//
//  ServiceTagsCell.m
//  37duxinB
//
//  Created by Zhang Xinrong on 22/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ServiceTagsCell.h"

@implementation ServiceTagsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tagsTitleArray = @[@"恋爱婚姻",@"职业发展",@"亲子教育",@"性心理",@"人际关系",@"个人成长",@"情绪压力",@"解梦",@"星座占卜"];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 60, 20)];
        _titleLab.center = CGPointMake(_titleLab.center.x,26.5);
        _titleLab.font = FONT_13;
        _titleLab.textColor = Color_4B4B4B;
        [self addSubview:_titleLab];
        
        _requiredImagView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_titleLab),_titleLab.frame.origin.x-2,8, 8)];
        [_requiredImagView setImage:[UIImage imageNamed:Image(@"star")]];
        [self addSubview:_requiredImagView];
        
        _textFild = [[UITextField alloc] initWithFrame:CGRectMake(90,0,SIZE.width-55-w(_titleLab),20)];
        _textFild.center = CGPointMake(_textFild.center.x, _titleLab.center.y);
        _textFild.tag = self.tag;
        _textFild.textColor = Color_4B4B4B;
        _textFild.font = FONT_12;
        _textFild.enabled = NO;
        [self addSubview:_textFild];
        
        _btnArray = [[NSMutableArray alloc] init];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 52, SIZE.width-20, 1)];
        _lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:_lineView];
    }
    return self;
}

-(void)updateUI:(NSDictionary *)dic
{
    _titleLab.text = [dic objectForKey:@"title"];
    _textFild.placeholder = [dic objectForKey:@"palceHolder"];
    
    CGSize size = [_titleLab boundingRectWithSize:CGSizeMake(0, 20)];
    [_titleLab setMj_w:size.width];
    [_requiredImagView setMj_x:left(_titleLab)];
    _requiredImagView.hidden = ![[dic objectForKey:@"required"] boolValue];

}

-(void)drawTags:(NSString *)string
{
    
    [_btnArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [_btnArray removeAllObjects];
    
    if(string.length ==0)
    {
        _textFild.hidden = NO;
    }
    else
    {
        _textFild.hidden = YES;
        NSArray *tagsArray = [string componentsSeparatedByString:@","];
        [tagsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger tag = [(NSString *)obj integerValue]-1;
            UILabel *label = [self tagStytle:_tagsTitleArray[tag] withFrame:CGRectMake(90+idx*85,0,70,25)];
            if (idx <= 2)
            {
                label.center = CGPointMake(label.center.x, _titleLab.center.y);
            }
            else
            if (idx >= 2 && idx <= 5)
            {
                label.center = CGPointMake(label.center.x-(3*85), _titleLab.center.y*2);
            }
            else
            {
                label.center = CGPointMake(label.center.x-(6*85), _titleLab.center.y*3);
            }
           
            [self addSubview:label];
            [_btnArray addObject:label];
        }];
    }
    
}

-(UILabel *)tagStytle:(NSString *)title withFrame:(CGRect)frame{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label.layer setBorderWidth:0.5f];
    [label.layer setCornerRadius:h(label)/2];
    [label.layer setBorderColor:Color_DCDCDC.CGColor];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor= Color_4C4C4C;
    label.font = [UIFont systemFontOfSize:13.0f];
    return label;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
