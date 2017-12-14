//
//  ViewController.m
//  WLScrollView
//
//  Created by 张子豪 on 2017/11/16.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import "ViewController.h"
#import "WLScrollView.h"
#import "LableView.h"
#import "textView.h"
#import "SubView.h"

@interface ViewController ()<WLScrollViewDelegate>
{
    WLScrollView *wlScrView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WLScreen_width, WLScreen_height)];
    bg.backgroundColor = [UIColor redColor];
    bg.alpha = 0.5;
    [self.view addSubview:bg];
    
    NSArray *titleAry = @[@"滚动1",@"滚动2",@"滚动3",@"滚动4(动画)"];
    for (int i = 0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(i*WLScreen_width/4, 100, WLScreen_width/4, 30);
        [btn setTitle:titleAry[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(addWLScreenView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        NSLog(@"1");
    }
   
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, WLScreen_height-100, WLScreen_width, 50)];
    lbl.textColor = [UIColor blackColor];
    lbl.textAlignment = 1;
    lbl.text = @"可定制可复用";
    lbl.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lbl];
    
    [self addWLScreenView4];

}


- (void)addWLScreenView:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
            [self addWLScreenView1];
            break;
        case 1:
            [self addWLScreenView2];
            break;
        case 2:
            [self addWLScreenView3];
            break;
        case 3:
            [self addWLScreenView4];
            break;
        default:
            break;
    }
}


#pragma mark - WLScrollViewDelegate

- (NSInteger)numOfContentViewScrollView:(WLScrollView *)scrollView{
    return 5;
}

- (WLSubView *)scrollView:(WLScrollView *)scrollView subViewFrame:(CGRect)frame cellAtIndex:(NSInteger)index{
    
    static NSString *cellID = @"123";
    static NSString *cellID2 = @"3453";
    static NSString *cellID3 = @"cell";
    
    if (index == 4 || index == 1) {
        textView *sub = (textView *)[scrollView dequeueReuseCellWithIdentifier:cellID2];
        if (!sub) {
            sub = [[textView alloc] initWithFrame:frame Identifier:cellID2];
        }
        sub.im.image = [UIImage imageNamed:@"3"];
        return sub;
    }else if (index == 2){
        
        SubView *sub = (SubView *)[scrollView dequeueReuseCellWithIdentifier:cellID3];
        if (!sub) {
            sub = [[SubView alloc]initWithFrame:frame Identifier:cellID3];
        }
        sub.img.image = [UIImage imageNamed:@"4"];
        return sub;
    }
    else  if (index == 0){
       
        LableView *sub = (LableView *)[scrollView dequeueReuseCellWithIdentifier:cellID];
        if (!sub) {
            sub = [[LableView alloc] initWithFrame:frame Identifier:cellID];
        }
        sub.im.image = [UIImage imageNamed:@"1"];
        return sub;
    }else{
        LableView *sub = (LableView *)[scrollView dequeueReuseCellWithIdentifier:cellID];
        if (!sub) {
            sub = [[LableView alloc] initWithFrame:frame Identifier:cellID];
        }
        sub.im.image = [UIImage imageNamed:@"2"];
        return sub;
    }
}

- (void)scrollView:(WLScrollView *)scrollView didSelectedAtIndex:(NSInteger)index{
    NSLog(@"点击 index %zd",index);
}

- (void)scrollView:(WLScrollView *)scrollView didCurrentCellAtIndex:(NSInteger)index{
    NSLog(@"现在显示的 index %zd",index);
}


- (void)addWLScreenView1{
    [wlScrView removeFromSuperview];
    wlScrView = nil;
    wlScrView = [[WLScrollView alloc]initWithFrame:CGRectMake(0, 150, WLScreen_width, 120)];
    wlScrView.delegate = self;
    wlScrView.isAnimation = NO;
    wlScrView.scale = 0.8;
    wlScrView.marginX = 5;
    wlScrView.backgroundColor = [UIColor clearColor];
    [wlScrView starRender];
    [self.view addSubview:wlScrView];
}

- (void)addWLScreenView2{
    [wlScrView removeFromSuperview];
    wlScrView = nil;
    wlScrView = [[WLScrollView alloc]initWithFrame:CGRectMake(0, 150, WLScreen_width, 120)];
    wlScrView.delegate = self;
    wlScrView.isAnimation = NO;
    wlScrView.scale = 1;
    wlScrView.marginX = 0;
    wlScrView.backgroundColor = [UIColor clearColor];
    [wlScrView starRender];
    [self.view addSubview:wlScrView];
}

- (void)addWLScreenView3{
    [wlScrView removeFromSuperview];
    wlScrView = nil;
    wlScrView = [[WLScrollView alloc]initWithFrame:CGRectMake(0, 150, WLScreen_width, 120)];
    wlScrView.delegate = self;
    wlScrView.isAnimation = NO;
    wlScrView.scale = 0.8;
    wlScrView.marginX = 0;
    wlScrView.backgroundColor = [UIColor clearColor];
    [wlScrView starRender];
    [self.view addSubview:wlScrView];
}

- (void)addWLScreenView4{
    [wlScrView removeFromSuperview];
    wlScrView = nil;
    wlScrView = [[WLScrollView alloc]initWithFrame:CGRectMake(0, 150, WLScreen_width, 400)];
    wlScrView.delegate = self;
    wlScrView.isAnimation = YES;
    
     //是否轮播。轮播设置为NO 或者不设置
    wlScrView.isEnableMargin = YES;
    wlScrView.scale = 0.7;
    wlScrView.marginX = 0;
    wlScrView.maxAnimationScale = 1;
    wlScrView.minAnimationScale = 0.8;
    wlScrView.backgroundColor = [UIColor clearColor];
    
     //设置起始位置 默认 0
//    [wlScrView setIndex:2];
    [wlScrView starRender];
    [self.view addSubview:wlScrView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
