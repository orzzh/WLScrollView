//
//  textView.m
//  WLScrollView
//
//  Created by 张子豪 on 2017/11/17.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import "textView.h"

@implementation textView

- (void)createUI{

    UILabel *v = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 50.0;
    v.layer.masksToBounds = YES;
    v.center = self.center;
    v.textColor = [UIColor orangeColor];
    v.text = @"样式二";
    v.font = [UIFont systemFontOfSize:20];
    v.textAlignment = 1;
    [self addSubview:self.im];
    [self addSubview:v];
    
}

- (UIImageView *)im{
    if (!_im) {
        _im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _im;
}

@end
