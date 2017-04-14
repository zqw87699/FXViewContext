//
//  FXLineView.m
//  TTTT
//
//  Created by 张大宗 on 2017/4/12.
//  Copyright © 2017年 张大宗. All rights reserved.
//
#import "FXLineView.h"
#import "ReactiveObjC.h"

@implementation FXLineView

-(void)fx_loadView {
    [super fx_loadView];
    [self setBackgroundColor:[UIColor clearColor]];
    _lineWidth = 1.0f / [[UIScreen mainScreen] scale];
    
    [RACObserve(self, lineColor) subscribeNext:^(id  _Nullable x) {
        [self setNeedsDisplay];
    }];
    
    [RACObserve(self, drawPosition) subscribeNext:^(id  _Nullable x) {
        [self setNeedsDisplay];
    }];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    
    if (_lineStyle == FXLineStyleDotted) {
        CGFloat lenghts[] = {5, 5};
        CGContextSetLineDash(context, 0, lenghts, 2);
    }
    
    CGContextSetLineWidth(context, _lineWidth);
    if (!_lineColor) {
        _lineColor = [UIColor grayColor];
    }
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextBeginPath(context);
    
    switch (_drawPosition) {
        case FXLineDrawPositionVerticalCenter:
            CGContextMoveToPoint(context, (self.bounds.size.width-_lineWidth)/2.0f, 0);
            CGContextAddLineToPoint(context, (self.bounds.size.width-_lineWidth)/2.0f, self.bounds.size.height);
            break;
        case FXLineDrawPositionHorizontalCenter:
            CGContextMoveToPoint(context, 0, (self.bounds.size.height-_lineWidth)/2.0f);
            CGContextAddLineToPoint(context, self.bounds.size.width, (self.bounds.size.height-_lineWidth)/2.0f);
            break;
        case FXLineDrawPositionTop:
            CGContextMoveToPoint(context, 0, _lineWidth/2.0f);
            CGContextAddLineToPoint(context, self.bounds.size.width, _lineWidth/2.0f);
            break;
        case FXLineDrawPositionLeft:
            CGContextMoveToPoint(context, _lineWidth/2.0f, 0);
            CGContextAddLineToPoint(context, _lineWidth/2.0f, self.bounds.size.height);
            break;
        case FXLineDrawPositionRight:
            CGContextMoveToPoint(context, self.bounds.size.width-_lineWidth/2.0f, 0);
            CGContextAddLineToPoint(context, self.bounds.size.width-_lineWidth/2.0f, self.bounds.size.height);
            break;
        case FXLineDrawPositionBottom:
            CGContextMoveToPoint(context, 0, self.bounds.size.height-_lineWidth/2.0f);
            CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height-_lineWidth/2.0f);
            break;
        default:
            break;
    }
    
    CGContextStrokePath(context);
}


-(void)setLineWidth:(CGFloat)lineWidth {
    if (_lineWidth == lineWidth) {
        return;
    }
    _lineWidth = MAX(0, lineWidth);
    [self setNeedsDisplay];
}

@end
