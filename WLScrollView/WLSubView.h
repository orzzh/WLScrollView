//
//  WLSubView.h
//  WLScrollView
//
//  Created by 张子豪 on 2017/11/16.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLSubViewDelegate<NSObject>

- (void)didSelectedRespond;

@end

@interface WLSubView : UIView

@property (nonatomic,weak)id<WLSubViewDelegate> delegate;
@property (nonatomic,strong)NSString            *identifier;
@property (nonatomic,assign)BOOL                isUser;   //是否在使用


- (instancetype)initWithFrame:(CGRect)frame Identifier:(NSString *)indentifier;

@end
