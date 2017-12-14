//
//  WLScrollView.m
//  WLScrollView
//
//  Created by 张子豪 on 2017/11/16.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import "WLScrollView.h"

@interface WLScrollView()<
UIScrollViewDelegate,
WLSubViewDelegate
>
{
    NSInteger _index; //标记数据源位置
    NSInteger _cellNum;//单元格 数量
    CGPoint   _point; //重置位置
    CGRect    _subFrame;
    CGFloat   _subViewWith;
    
}

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *subViewAry;     //容器数组
@property (nonatomic,strong)NSMutableArray *reuseViewAry;   //复用池view数组
@property (nonatomic,strong)NSMutableArray *userViewAry;    //在使用view数组


@end

@implementation WLScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma  mark - 设置起始位置

- (void)setIndex:(NSInteger)index{
    _index = index;
}


#pragma  mark - 复用池查找

- (WLSubView *)dequeueReuseCellWithIdentifier:(NSString *)identifier{
    for (WLSubView *sub in self.reuseViewAry) {
        if ([sub.identifier isEqualToString:identifier] && !sub.isUser) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.reuseViewAry removeObject:sub];
            });
            return sub;
        }
    }
    return nil;
}



- (void)createUI{
    _index = 0;
    _scale = 0.7;
    _marginX = 10;
    _isAnimation = YES;
    _isEnableMargin = NO;
    _maxAnimationScale = 1.2;
    _minAnimationScale = 0.9;
    
    [self setDefault];
    [self setSubView];
}

- (void)setDefault{
    _subViewWith = self.frame.size.width * self.scale;
    _point = CGPointMake(_subViewWith*2, 0);
    _subFrame = CGRectMake(self.marginX ,0 ,_subViewWith - self.marginX * 2 ,self.frame.size.height);
}

- (void)setSubView{
    self.scrollView.frame = CGRectMake((self.frame.size.width-_subViewWith)/2, 0, _subViewWith, self.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(_subViewWith*5, self.frame.size.height);
    
    [self.subViewAry removeAllObjects];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i<5; i++) {
        UIView *sub = [[UIView alloc]initWithFrame:CGRectMake(i*_subViewWith, 0, _subViewWith, self.frame.size.height)];
        [self.scrollView addSubview:sub];
        [self.subViewAry addObject:sub];
    }
    
    if (self.isAnimation) {
        for (UIView *sub in self.subViewAry) {
            sub.layer.transform = CATransform3DMakeScale(_minAnimationScale, _minAnimationScale, 1.0);
        }
        UIView *sub = (UIView *)[self.subViewAry objectAtIndex:2];
        sub.layer.transform = CATransform3DMakeScale(_maxAnimationScale, _maxAnimationScale, 1.0);
    }
}

- (void)starRender{
    
    [self setDefault];
    [self setSubView];
    [self upConfig];
}

#pragma mark - 刷新数据
- (void)upConfig{
    [self checkOffset];//更新偏移
    [self checkCellnum];//更新Cellnum
    [self refreshCell];//更新显示数据
    [self currentIndex];//返回当前index
}

- (void)currentIndex{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:didCurrentCellAtIndex:)]) {
        [self.delegate scrollView:self didCurrentCellAtIndex:_index];
    }
}

- (void)checkOffset{
    self.scrollView.contentOffset = _point;
    
    if (_isAnimation == NO) {return;}
    
    for (int i = 0 ; i<self.subViewAry.count; i++ ) {
        UIView *sub = [self.subViewAry objectAtIndex:i];
        if (i == 2) {
            sub.layer.transform = CATransform3DMakeScale(self.maxAnimationScale, self.maxAnimationScale, 1.0);
        }else{
            sub.layer.transform = CATransform3DMakeScale(self.minAnimationScale, self.minAnimationScale, 1.0);
        }
    }
}

- (void)checkCellnum{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numOfContentViewScrollView:)]) {
        _cellNum = [self.delegate numOfContentViewScrollView:self];
    }else{
        NSAssert(NO, @"未实现 WLScrollViewDelegate 方法 numOfContentViewScrollView:");
    }
}


- (void)refreshCell{

    //获取数据源index数组
    NSArray *indexAry = [self checkIndexAry];
    
    //边缘隐藏
    [self checkHiden];
    
    for (int i = 0; i<5; i++) {
        
        //获取自定义view
        if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:subViewFrame:cellAtIndex:)]) {
            NSInteger index = [[indexAry objectAtIndex:i] integerValue];
            UIView *subView = [self.subViewAry objectAtIndex:i];
            
            //清除原有自定义view 在使用数组中移除 加入可复用数组
            for (WLSubView *sub in subView.subviews) {
                sub.isUser = NO;
                [self.userViewAry removeObject:sub];
                [self.reuseViewAry addObject:sub];
                [sub removeFromSuperview];
            }
            WLSubView *sub_view = [self.delegate scrollView:self subViewFrame:_subFrame cellAtIndex:index];
            sub_view.delegate = self;
            sub_view.isUser = YES;
            [self.userViewAry addObject:sub_view];
            [subView addSubview:sub_view];
        }else{
            NSAssert(NO, @"未实现 WLScrollViewDelegate 方法 scrollView:subViewFrame:cellAtIndex:");
        }
    }
}

#pragma mark - 边缘隐藏

- (void)checkHiden{
    if (!_isEnableMargin) {return;}
    if (_index == 0) {
        UIView *subView = [self.subViewAry objectAtIndex:0];
        UIView *subView1 = [self.subViewAry objectAtIndex:1];
        subView.hidden = YES;
        subView1.hidden = YES;
    }else
    if (_index == 1) {
        UIView *subView = [self.subViewAry objectAtIndex:0];
        subView.hidden = YES;
        UIView *subView1 = [self.subViewAry objectAtIndex:1];
        subView1.hidden = NO;
    }else
    if (_index == 2) {
        UIView *subView = [self.subViewAry objectAtIndex:0];
        subView.hidden = NO;
        UIView *subView1 = [self.subViewAry objectAtIndex:1];
        subView1.hidden = NO;
    }
    if (_index == _cellNum-1) {
        UIView *subView = [self.subViewAry objectAtIndex:3];
        UIView *subView1 = [self.subViewAry objectAtIndex:4];
        subView.hidden = YES;
        subView1.hidden = YES;
    }else
    if (_index == _cellNum-2) {
        UIView *subView = [self.subViewAry objectAtIndex:4];
        subView.hidden = YES;
        UIView *subView1 = [self.subViewAry objectAtIndex:3];
        subView1.hidden = NO;
    }else
    if (_index == _cellNum-3) {
        UIView *subView = [self.subViewAry objectAtIndex:3];
        subView.hidden = NO;
        UIView *subView1 = [self.subViewAry objectAtIndex:4];
        subView1.hidden = NO;
    }
}

#pragma  mark - 计算当前cell数据源index 存入数组

- (NSArray *)checkIndexAry{
    
    //超出长度
    if (_index >= _cellNum) {
        _index = 0;
    }
    if (_index < 0) {
        _index = _cellNum + _index;
    }
    NSMutableArray *ary = [NSMutableArray new];
    NSInteger index_0 = _index - 2;
    NSInteger index_1 = _index - 1;
    NSInteger index_2 = _index;
    NSInteger index_3 = _index + 1;
    NSInteger index_4 = _index + 2;
    if (index_1 < 0) {
        index_1 = _cellNum + index_1;
    }
    if (index_0 < 0) {
        index_0 = _cellNum + index_0;
    }
    if (index_3 >= _cellNum) {
        index_3 = index_3 - _cellNum;
    }
    if (index_4 >= _cellNum) {
        index_4 = index_4 - _cellNum;
    }
    [ary addObject:[self stringOfint:index_0]];
    [ary addObject:[self stringOfint:index_1]];
    [ary addObject:[self stringOfint:index_2]];
    [ary addObject:[self stringOfint:index_3]];
    [ary addObject:[self stringOfint:index_4]];
    return ary;
}


#pragma mark - 动画函数

- (void)animation{
    if (!_isAnimation) {
        return;
    }
    
    UIView *sub = (UIView*)[self.subViewAry objectAtIndex:2];
    UIView *subRight = (UIView*)[self.subViewAry objectAtIndex:3];
    UIView *subLift = (UIView*)[self.subViewAry objectAtIndex:1];

    CGFloat sum = self.scrollView.contentOffset.x+(_subViewWith)/2;
    CGFloat centerX = sub.center.x;
    CGFloat diff = sum - centerX;
    CGFloat shortX = _subViewWith;

    if (centerX <= sum && fabs(diff) <= shortX) {
        //向左滑动
        CGFloat scale = _maxAnimationScale-fabs(diff)/shortX*  (_maxAnimationScale - _minAnimationScale);
        sub.layer.transform = CATransform3DMakeScale(scale, scale, 1.0);
        CGFloat scale1 = _minAnimationScale+fabs(diff)/shortX*  (_maxAnimationScale - _minAnimationScale);
        subRight.layer.transform = CATransform3DMakeScale(scale1, scale1, 1.0);
        
    }
    
    if (centerX >= sum && fabs(diff) <= shortX) {
        //向右滑动
        CGFloat scale = _maxAnimationScale-fabs(diff)/shortX * (_maxAnimationScale - _minAnimationScale);
        sub.layer.transform = CATransform3DMakeScale(scale, scale, 1.0);
        CGFloat scale1 = _minAnimationScale+fabs(diff)/shortX * (_maxAnimationScale - _minAnimationScale);
        subLift.layer.transform = CATransform3DMakeScale(scale1, scale1, 1.0);
    }
}



#pragma mark - scrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    if (_index == 0 && contentOffsetX < _point.x && _isEnableMargin) {
        scrollView.contentOffset = _point;
        return;
    }
    if (_index == _cellNum-1 && contentOffsetX > _point.x && _isEnableMargin) {
        scrollView.contentOffset = _point;
        return;
    }
    
    //判断左滑右滑
    if (contentOffsetX >= _subViewWith*3) {
        
        //offset向右滑动 +1
        _index += 1;

        //更新offset 刷新cell
        [self upConfig];
    }
    if (contentOffsetX <= _subViewWith){
        
        //向左滑动
        _index -= 1;

        //更新offset 刷新cell
        [self upConfig];
    }
    [self animation];
}


#pragma mark - WLSubViewDelegate
- (void)didSelectedRespond{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:didSelectedAtIndex:)]) {
        [self.delegate scrollView:self didSelectedAtIndex:_index];
    }else{
        NSAssert(NO, @"未实现 WLSubViewDelegate scrollView:didSelectedAtIndex:方法");
    }
}



- (NSString *)stringOfint:(NSInteger)num{
    return [NSString stringWithFormat:@"%zd",num];
}


#pragma mark - getter

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        CGFloat height = self.frame.size.height;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((self.frame.size.width-_subViewWith)/2, 0, _subViewWith, height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.layer.masksToBounds = NO;
        _scrollView.contentSize = CGSizeMake(_subViewWith*5, height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.decelerationRate = 0.1;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray *)subViewAry{
    if (!_subViewAry) {
        _subViewAry = [NSMutableArray new];
    }
    return _subViewAry;
}

- (NSMutableArray *)reuseViewAry{
    if (!_reuseViewAry) {
        _reuseViewAry = [NSMutableArray new];
    }
    return _reuseViewAry;
}

-  (NSMutableArray *)userViewAry{
    if (!_userViewAry) {
        _userViewAry = [NSMutableArray new];
    }
    return _userViewAry;
}

#pragma mark - setter

- (void)setScrollViewType:(ScrollType)scrollViewType{
    if (scrollViewType == WLScrollViewRepeat) {
        self.scrollView.delegate = self;
    }
    _scrollViewType = scrollViewType;
}



@end
