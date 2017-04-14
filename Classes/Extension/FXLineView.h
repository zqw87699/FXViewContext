//
//  FXLineView.h
//  TTTT
//
//  Created by 张大宗 on 2017/4/12.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "BaseFXView.h"

/**
 *  线条绘制位置
 */
typedef NS_ENUM(NSInteger, FXLineDrawPosition) {
    
    /**
     *  垂直居中
     */
    FXLineDrawPositionVerticalCenter = 0,
    
    /**
     *  水平居中
     */
    FXLineDrawPositionHorizontalCenter = 1,
    
    /**
     *  底部
     */
    FXLineDrawPositionBottom = 2,
    
    /**
     *  顶部
     */
    FXLineDrawPositionTop = 3,
    
    /**
     * 左边
     */
    FXLineDrawPositionLeft = 4,
    
    /**
     * 右边
     */
    FXLineDrawPositionRight = 5,
};

/**
 *  线条样式
 */
typedef NS_ENUM(NSInteger, FXLineStyle) {
    
    /**
     * 实线
     */
    FXLineStyleSolid = 0,
    
    /**
     * 虚线
     */
    FXLineStyleDotted = 1,
};


/**
 *  线条视图
 */
@interface FXLineView : BaseFXView

/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 *  是否水平
 */
@property (nonatomic, assign) FXLineDrawPosition drawPosition;

/**
 *  线条样式
 */
@property (nonatomic, assign) FXLineStyle lineStyle;

/**
 *  线条宽度
 *  default     1/scale
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end
