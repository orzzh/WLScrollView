//
//  SubView.h
//  ScrollView
//
//  Created by 张子豪 on 2017/11/7.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import "WLSubView.h"



@interface SubView : WLSubView

@property (nonatomic,strong)UILabel *title;//网名
@property (nonatomic,strong)UILabel *deslbl;//星座描述
@property (nonatomic,strong)UILabel *tiplbl;//签名
@property (nonatomic,strong)UIImageView *img;//头像
@property (nonatomic,strong)UIImageView *gender;//性别
@property (nonatomic,strong)UIImageView *focus;//关注


- (void)star;
- (void)stop;
@end
