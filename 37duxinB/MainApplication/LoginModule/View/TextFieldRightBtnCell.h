//
//  TextFieldRightBtnCell.h
//  37duxinB
//
//  Created by Zhang Xinrong on 02/03/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^textFieldBlock)(UITextField *textField);
@interface TextFieldRightBtnCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)UILabel *titleLab;
@property(nonatomic,retain)UIImageView *requiredImagView;
@property(nonatomic,retain)UITextField *textFild;
@property(nonatomic,retain)UIButton *showDetailBtn;
@property(nonatomic,retain)UIView *lineView;
@property(nonatomic,copy)void(^showDeailBlock)(void);
@property(nonatomic,copy)textFieldBlock textFieldBlock;

-(void)updateUI:(NSDictionary *)dic;
@end
