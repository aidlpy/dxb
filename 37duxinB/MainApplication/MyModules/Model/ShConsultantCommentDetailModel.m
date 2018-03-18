//
//  ShConsultantCommentDetailModel.m
//  duxin
//
//  Created by felix on 2018/1/28.
//  Copyright © 2018年 37duxin. All rights reserved.
//

#import "ShConsultantCommentDetailModel.h"

@implementation ShConsultantCommentDetailModel

+(void)arrayEmModel:(NSArray *)array model:(void(^)(BOOL isStop,ShConsultantCommentDetailModel *model))fetchModelBlock{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        __block BOOL isstop = (BOOL)stop;
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary *)obj;
             ShConsultantCommentDetailModel *model = [ShConsultantCommentDetailModel new];
            NSNumber *cid = [dic objectForKey:@"cid"];
            model.cid = cid.integerValue;
            model.evaluation = [dic objectForKey:@"evaluation"];
            NSNumber *evaluation_at = [dic objectForKey:@"evaluation_at"];
            model.evaluation_at = evaluation_at.integerValue;
            NSNumber *fid = [dic objectForKey:@"fid"];
            model.fid = fid.integerValue;
            NSNumber *id = [dic objectForKey:@"id"];
            model.id = id.integerValue;
            NSNumber *is_initiative = [dic objectForKey:@"is_initiative"];
            model.is_initiative = is_initiative.integerValue;
            model.is_main = [dic objectForKey:@"is_main"];
            NSNumber *oid = [dic objectForKey:@"oid"];
            model.oid = oid.integerValue;
            model.order_number = [dic objectForKey:@"order_number"];
            if (![[dic objectForKey:@"reply"] isEqual:[NSNull null]]) {
                 model.reply = [dic objectForKey:@"reply"];
            }
            if (![[dic objectForKey:@"reply_at"] isEqual:[NSNull null]]) {
                model.reply = [dic objectForKey:@"reply"];
            }
            NSNumber *start = [dic objectForKey:@"start"];
            model.start = start.integerValue;
            
           
            model.type = [dic objectForKey:@"type"];
            
            NSNumber *uid = [dic objectForKey:@"uid"];
            model.uid = uid.integerValue;
            
            NSDictionary *userDic = [dic objectForKey:@"user"];
            if (userDic != nil) {
                model.user = [ShUserModel new];
                
                model.user.avatar = [userDic objectForKey:@"avatar"];
                
                NSNumber *gender = [userDic objectForKey:@"gender"];
                model.user.gender = gender.integerValue;
                
                NSNumber *id = [userDic  objectForKey:@"id"];
                model.user.id = id.integerValue;
                
                NSNumber *device = [userDic objectForKey:@"device"];
                model.user.device = device.integerValue;
                
                model.user.nickname  = [userDic objectForKey:@"nickname"];
    
            }
            fetchModelBlock(isstop,model);
        }

        
    }];
    
}

@end
