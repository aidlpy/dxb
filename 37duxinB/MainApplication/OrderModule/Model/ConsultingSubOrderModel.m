//
//  ConsultingSubOrderModel.m
//  37duxinB
//
//  Created by Zhang Xinrong on 14/02/2018.
//  Copyright © 2018 37duxin. All rights reserved.
//

#import "ConsultingSubOrderModel.h"

@implementation ConsultingSubOrderModel
+(void)fetchArray:(NSArray *)array model:(void(^)(BOOL stop,ConsultingSubOrderModel *model))fetchModelBlock{
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        ConsultingSubOrderModel *model = [ConsultingSubOrderModel new];
        model.orderId = [dic objectForKey:@"id"];
        model.orderOID = [dic objectForKey:@"oid"];
        model.orderOldPrice = [dic objectForKey:@"price"];
        model.orderSubStatus = [dic objectForKey:@"sub_status"];
        model.orderUID = [dic objectForKey:@"uid"];
        
        NSDictionary *userInfoDic = [dic objectForKey:@"userInfo"];
        model.consultantUsername = [userInfoDic objectForKey:@"nickname"];
        model.consultantUserId = [userInfoDic objectForKey:@"id"];
        model.consultantUserAvatar = [userInfoDic objectForKey:@"avatar"];
        
        //package
        NSDictionary *packageInfoDic = [dic objectForKey:@"packageInfo"];
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
        
        NSDictionary *orderInfoDic  = [dic objectForKey:@"orderInfo"];
        model.orderCustomerDesc = [orderInfoDic objectForKey:@"customer_desc"];
        model.orderReservationID = [orderInfoDic objectForKey:@"reservation_order_id"];
        model.orderInfoZXAge = [orderInfoDic objectForKey:@"zx_age"];
        model.orderInfoZXArea = [orderInfoDic objectForKey:@"zx_area"];
        model.orderInfoZXCity = [orderInfoDic objectForKey:@"zx_city"];
        model.orderInfoZXGender = [orderInfoDic objectForKey:@"zx_gender"];
        model.orderInfoZXName = [orderInfoDic objectForKey:@"zx_name"];
        model.orderInfoZXProvince = [orderInfoDic objectForKey:@"zx_province"];
        
        fetchModelBlock(stop,model);
                                     
    }];
        
}
        
@end
