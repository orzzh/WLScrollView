//
//  WLSubView.m
//  WLScrollView
//
//  Created by 张子豪 on 2017/11/16.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import "WLSubView.h"

@interface WLSubView ()
{
    CGPoint isPoint;
}

@end

@implementation WLSubView

- (instancetype)initWithFrame:(CGRect)frame Identifier:(NSString *)indentifier{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.identifier = indentifier;
        
        [self createUI];

    }
    return self;
}

#pragma mark - 重写

- (void)createUI{
    
    
}


#pragma mark - touchesDelegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    isPoint = [touch locationInView:self];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint Point = [touch locationInView:self];
    if (Point.x == isPoint.x && Point.y == isPoint.y
        && self.delegate
        && [self.delegate respondsToSelector:@selector(didSelectedRespond)]) {
        [self.delegate didSelectedRespond];
    }
}


@end
