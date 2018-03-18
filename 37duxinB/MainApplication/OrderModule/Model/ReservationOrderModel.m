//
//  ReservationOrderModel.m
//  37duxinB
//
//  Created by Zhang Xinrong on 13/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ReservationOrderModel.h"

@implementation ReservationOrderModel

+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,ReservationOrderModel *model))fetchModelBlock{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        ReservationOrderModel *model = [ReservationOrderModel new];
        model.orderId = [dic objectForKey:@"id"];
        model.orderUID = [dic objectForKey:@"uid"];
        model.orderCID = [dic objectForKey:@"cid"];
        model.orderCSID = [dic objectForKey:@"cs_id"];
        model.orderOldPrice = [dic objectForKey:@"old_price"];
        model.orderPrice = [dic objectForKey:@"price"];
        model.orderType = [dic objectForKey:@"type"];
        model.orderReservationID = [dic objectForKey:@"reservation_order_id"];
        model.orderConsultationStatus = [dic objectForKey:@"consultation_status"];
        model.orderStatus = [dic objectForKey:@"status"];
        model.orderCustomerDesc = [dic objectForKey:@"customer_desc"];
        
        //consultantProfile
        NSDictionary *consultantProfileDic = [dic objectForKey:@"userInfo"];
        model.consultantUserId = [consultantProfileDic objectForKey:@"id"];
        model.consultantUsername = [consultantProfileDic objectForKey:@"nickname"];
        model.consultantUserAvatar = [consultantProfileDic objectForKey:@"avatar"];
        
        //package
        NSDictionary *packageInfoDic = [dic objectForKey:@"package"];
        model.packageId = [packageInfoDic objectForKey:@"id"];
        model.packageTitle = [packageInfoDic objectForKey:@"title"];
        model.packageSerContent = [packageInfoDic objectForKey:@"service_content"];
        model.packageSerTimes = [packageInfoDic objectForKey:@"service_times"];
        model.packageSerHours = [packageInfoDic objectForKey:@"service_hours"];
        model.packageSerType = [packageInfoDic objectForKey:@"service_type"];
        model.packageSinglePrice = [packageInfoDic objectForKey:@"single_price"];
        NSString *tags = [packageInfoDic objectForKey:@"tags"];
        model.packageTags = [tags componentsSeparatedByString:@","];
        NSString *consultation_way_string = [packageInfoDic objectForKey:@"consultation_way"];
        model.packageConsultationWay = [consultation_way_string componentsSeparatedByString:@","];
        
        fetchModelBlock(stop,model);
        
    }];
}

@end
