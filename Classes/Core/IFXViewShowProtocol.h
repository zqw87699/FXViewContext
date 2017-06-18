//
//  IFXViewShowProtocol.h
//  TTTT
//
//  Created by 张大宗 on 2017/4/10.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FXViewPushType){
    /*
     *  警告
     */
    FXViewPushTypeAlert=0,
    
    /*
     *  左推入
     */
    FXViewPushTypeLeft=1,
    
    /*
     *  右推入
     */
    FXViewPushTypeRight=2,
    
    /*
     *  顶部推入
     */
    FXViewPushTypeTop=3,
    
    /*
     *  底部推入
     */
    FXViewPushTypeBottom=4,
};

@protocol IFXViewShowProtocol <NSObject>

@optional
/**
 *  动画时长
 *
 *  default 0.25f
 */
- (NSTimeInterval) animatedDuration;

/**
 *  是否拥有背景
 *
 *  default YES
 */
- (BOOL)hasBackground;

/**
 *  透明度
 *
 *  @return 0.0~1.0
 *
 *  default 0.3f
 */
- (CGFloat)backgroundAlpha;

/**
 *  页面推入方式
 *
 *  default FXViewPushTypeNone
 */
- (FXViewPushType)pushType;

/**
 *  是否点击推出
 *
 *  default YES
 */
- (BOOL)touchClose;

@required

/**
 *  页面尺寸
 */
- (CGSize)viewSize;


@end
