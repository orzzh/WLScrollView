//
//  WLScrollView.h
//  WLScrollView
//
//  Created by 张子豪 on 2017/11/16.
//  Copyright © 2017年 张子豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLSubView.h"

@class WLScrollView;

typedef NS_ENUM(NSInteger) {
    
    WLScrollViewRepeat = 1,
    
}ScrollType;

@protocol WLScrollViewDelegate<NSObject>

@required


/**
 获取cell总数

 @param scrollView  WLScrollView
 @return            返回cell总数
 */
- (NSInteger)numOfContentViewScrollView:(WLScrollView *)scrollView;


/**
 获取复用View

 @param scrollView  WLScrollView
 @param frame       返回View的frame
 @param index       当前显示的数据index
 @return            返回自定义View
 */
- (WLSubView *)scrollView:(WLScrollView *)scrollView subViewFrame:(CGRect)frame cellAtIndex:(NSInteger)index;

@optional

/**
  点击响应

 @param scrollView   WLScrollView
 @param index        当前点击事件所对应的数据index
 */
- (void)scrollView:(WLScrollView *)scrollView didSelectedAtIndex:(NSInteger)index;


/**
  当前位置的数据index

 @param scrollView  WLScrollView
 @param index       当前显示所对应的数据index
 */
- (void)scrollView:(WLScrollView *)scrollView didCurrentCellAtIndex:(NSInteger)index;

@end

@interface WLScrollView : UIView

@property (nonatomic,assign)id<WLScrollViewDelegate> delegate;

@property (nonatomic,assign)ScrollType scrollViewType;


/**
     是否启用动画 默认yes
 */
@property (nonatomic,assign)BOOL isAnimation;

/**
  边缘是否限制滚动 默认NO
 */
@property (nonatomic,assign)BOOL isEnableMargin;

/**
	 子view所占比例 建议 0.6～1.0
 */
@property (nonatomic,assign)CGFloat scale;

/**
	子view中内容据两边距离 建议 0～20
 */
@property (nonatomic,assign)CGFloat marginX;//左边距

/**
	 子view动画效果放大比例 建议 1～1.2
 */
@property (nonatomic,assign)CGFloat maxAnimationScale;//最大缩放比例

/**
	 子view动画效果缩小比例 建议 0.6～1
 */
@property (nonatomic,assign)CGFloat minAnimationScale;//最小缩放比例

/**
	 开始渲染
 */
- (void)starRender;


/**
    复用
 @param identifier  复用标识
 @return            返回复用池中自定义View
 */
- (WLSubView *)dequeueReuseCellWithIdentifier:(NSString *)identifier;


/**
  设置起始位置

 @param index 数据源起始位置index
 */
- (void)setIndex:(NSInteger)index;






@end
