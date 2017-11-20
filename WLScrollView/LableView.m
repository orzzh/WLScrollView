//
//  LableView.m
//  WLScrollView
//
//  Created by 张子豪 on 2017/11/17.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import "LableView.h"

@implementation LableView


- (void)createUI{
    
    self.layer.cornerRadius = 10;
    
    self.lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-60, self.frame.size.width, 30)];
    self.lbl.textAlignment = 1;
    self.lbl.textColor = [UIColor redColor];
    self.lbl.backgroundColor = [UIColor whiteColor];
    self.lbl.text = @"样式一";
    self.lbl.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.im];
    [self addSubview:self.lbl];
    
    
}



- (UIImageView *)im{
    if (!_im) {
        _im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _im;
}



@end
