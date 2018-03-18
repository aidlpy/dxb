//
//  TitleWithItemCell.m
//  37duxinB
//
//  Created by 37duxin on 07/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "TitleWithItemCell.h"

@implementation TitleWithItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(22, 0, 52, 20)];
        _titleLab.center = CGPointMake(_titleLab.center.x,26.5);
        _titleLab.font = FONT_13;
        _titleLab.textColor = Color_4B4B4B;
        [self addSubview:_titleLab];
        
        _requiredImagView = [[UIImageView alloc] initWithFrame:CGRectMake(left(_titleLab),_titleLab.frame.origin.x-2,8, 8)];
        [_requiredImagView setImage:[UIImage imageNamed:Image(@"star")]];
        [self addSubview:_requiredImagView];
        
        _textFild = [[UITextField alloc] initWithFrame:CGRectMake(90,0,SIZE.width-55-w(_titleLab),20)];
        _textFild.center = CGPointMake(_textFild.center.x, _titleLab.center.y);
        _textFild.delegate = self;
        _textFild.tag = self.tag;
        _textFild.textColor = Color_4B4B4B;
        _textFild.font = FONT_12;
        [_textFild addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    
        [self addSubview:_textFild];
        
        
        _itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(SIZE.width-40,0,40, 12)];
        _itemLabel.textColor = Color_BABABA;
        _itemLabel.center = CGPointMake(_itemLabel.center.x, _titleLab.center.y);
        _itemLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_itemLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 52, SIZE.width-20, 1)];
        lineView.backgroundColor = Color_F1F1F1;
        [self addSubview:lineView];
        
    }
    return  self;
    
}


-(void)textField1TextChange:(UITextField *)textField{
    if (_textFieldBlock) {
        textField.tag = self.tag;
      _textFieldBlock(textField);
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (_textFieldBlock) {
//        textField.tag = self.tag;
//        NSLog(@"string==>%@",string);
//
//    }
    return YES;
}



-(void)updateUI:(NSDictionary *)dic{
    
    _titleLab.text = [dic objectForKey:@"title"];
    CGSize size = [_titleLab boundingRectWithSize:CGSizeMake(0, 20)];
    [_titleLab setMj_w:size.width];
    [_textFild setMj_x:left(_titleLab)+15];
    _requiredImagView.hidden = ![[dic objectForKey:@"required"] boolValue];
    
    _textFild.placeholder = [dic objectForKey:@"palceHolder"];
    _textFild.enabled = [[dic objectForKey:@"editable"] boolValue];
    _itemLabel.text = [dic objectForKey:@"item"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
