//
//  SubView.m
//  ScrollView
//
//  Created by 张子豪 on 2017/11/7.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import "SubView.h"
@interface SubView()
{
    UIImageView *animation;
}
@property (nonatomic,strong)UIView *bg;
@end


@implementation SubView


- (void)createUI{
    [self.bg addSubview:self.img];
    
    //白
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, self.img.frame.size.height, self.img.frame.size.width, self.frame.size.height)];
    vi.backgroundColor = [UIColor whiteColor];
    [self.bg addSubview:vi];
    
//    性别
    _gender = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    _gender.center = CGPointMake(self.bg.frame.size.width-26, vi.frame.origin.y);
    _gender.image = [UIImage imageNamed:@"sex"];
    
//    样式
    UIView *viewGray = [[UIView alloc]initWithFrame:CGRectMake(self.bg.frame.size.width/2-7.5, self.deslbl.frame.origin.y+25, 15, 3)];
    viewGray.backgroundColor = [UIColor grayColor];
    viewGray.layer.cornerRadius = 1.5;
    viewGray.alpha = 0.3;
    [self.bg addSubview:viewGray];

    
    animation = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.img.frame.size.width, self.img.frame.size.height)];
    
    [self.bg addSubview:_gender];
    [self.bg addSubview:self.title];
    [self.bg addSubview:self.tiplbl];

}







#pragma  mark - animation

- (void)star{
    animation.image = self.img.image;
    animation.alpha = 1;
    [self.img addSubview:animation];
    [UIView animateWithDuration:2.0 animations:^{
        animation.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 animations:^{
            animation.alpha = 0;
        } completion:^(BOOL finished) {
            animation.layer.transform = CATransform3DIdentity;
            [animation removeFromSuperview];
        }];
    }];
}

- (void)stop{
    [UIView animateWithDuration:0.5 animations:^{
        animation.alpha=0;
    } completion:^(BOOL finished) {
        [animation removeFromSuperview];
    }];
}




- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/3*2+5, _img.frame.size.width, 20)];
        _title.textColor = [UIColor blackColor];
        _title.text = @"啦啦啦";
        _title.font = [UIFont systemFontOfSize:18];
        _title.textAlignment =1;
        _title.backgroundColor = [UIColor whiteColor];
    }
    return _title;
}


- (UILabel *)deslbl{
    if (!_deslbl) {
        _deslbl = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/3*2+23, _img.frame.size.width, 20)];
        _deslbl.text = @"距离205m";
        _deslbl.textColor = [UIColor blackColor];
        _deslbl.font = [UIFont systemFontOfSize:9];
        _deslbl.textAlignment =1;
        _deslbl.backgroundColor = [UIColor whiteColor];
        [self.bg addSubview:_deslbl];
    }
    return _deslbl;
}

- (UILabel *)tiplbl{
    if (!_tiplbl) {
        _tiplbl = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50, self.frame.size.width, 30)];
        _tiplbl.text = @"样式三";
        _tiplbl.textColor = [UIColor blackColor];
        _tiplbl.lineBreakMode = NSLineBreakByWordWrapping;
        _tiplbl.textAlignment = 1;
        _tiplbl. backgroundColor = [UIColor clearColor];
        _tiplbl.font = [UIFont systemFontOfSize:20];
        _tiplbl.backgroundColor = [UIColor whiteColor];
    }
    return _tiplbl;
}


- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/3*2)];
        _img.backgroundColor = [UIColor redColor];
        _img.userInteractionEnabled = YES;
        _img.layer.masksToBounds = YES;
    }
    return _img;
}

- (UIView *)bg{
    if (!_bg) {
        _bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bg.backgroundColor = [UIColor blackColor];
        _bg.layer.cornerRadius = 5;
        _bg.layer.masksToBounds = YES;
        [self addSubview:_bg];
    }
    return _bg;
}

- (UIImageView *)focus{
    if (!_focus) {
        _focus = [[UIImageView alloc]initWithFrame:CGRectMake(self.bg.frame.size.width, 16, 40, 40)];
        _focus.image = [UIImage imageNamed:@"focus"];
        _focus.userInteractionEnabled=YES;
        [self.bg addSubview:_focus];
    }
    return _focus;
}

@end
