//
//  UIView+SetCornerRadius.m
//  TestCorner
//
//  Created by JianF.Sun on 17/6/7.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import "UIView+SetCornerRadiusAndBorderLine.h"

@implementation UIView (SetCornerRadiusAndBorderLine)

-(void)setCornerRadiusWithType:(Corner_Radius_Or_BorderLine_TYPE)type Radius:(CGFloat)cornerradius{
    
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 0;
    UIRectCorner rectcorners ;
    if (type==Corner_Radius_Or_BorderLine_All) {
        rectcorners = UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight;
        self.layer.cornerRadius = cornerradius;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        return;
    }else if (type==Corner_Radius_Or_BorderLine_UP){
        rectcorners = UIRectCornerTopLeft|UIRectCornerTopRight;
    }else if (type==Corner_Radius_Or_BorderLine_RIGHT){
        rectcorners = UIRectCornerTopRight|UIRectCornerBottomRight;
    }else if (type==Corner_Radius_Or_BorderLine_DOWN){
        rectcorners = UIRectCornerBottomLeft|UIRectCornerBottomRight;
    }else if (type==Corner_Radius_Or_BorderLine_LEFT){
        rectcorners = UIRectCornerTopLeft|UIRectCornerBottomLeft;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectcorners cornerRadii:CGSizeMake(cornerradius, cornerradius)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];        maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask  = maskLayer;
  
}

-(void)drawBorderLineWithType:(Corner_Radius_Or_BorderLine_TYPE)type lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor{
    
    self.layer.masksToBounds = YES;
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    if (type==Corner_Radius_Or_BorderLine_All) {
        self.layer.borderWidth = lineWidth;
        self.layer.borderColor = lineColor.CGColor;
        return;
    }else if (type==Corner_Radius_Or_BorderLine_UP){
        [bezierPath moveToPoint:CGPointMake(0.0f, lineWidth)];
        [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, lineWidth)];
    }else if (type==Corner_Radius_Or_BorderLine_RIGHT){
        [bezierPath moveToPoint:CGPointMake(self.frame.size.width-lineWidth, 0.0f)];
        [bezierPath addLineToPoint:CGPointMake( self.frame.size.width-lineWidth, self.frame.size.height)];
    }else if (type==Corner_Radius_Or_BorderLine_DOWN){
        [bezierPath moveToPoint:CGPointMake(0.0f, self.frame.size.height-lineWidth)];
        [bezierPath addLineToPoint:CGPointMake( self.frame.size.width, self.frame.size.height-lineWidth)];
    }else if (type==Corner_Radius_Or_BorderLine_LEFT){
        [bezierPath moveToPoint:CGPointMake(0.0f+lineWidth, self.frame.size.height)];
        [bezierPath addLineToPoint:CGPointMake(0.0f+lineWidth, 0.0f)];
    }
    
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = lineWidth;
    
    [self.layer addSublayer:shapeLayer];
    
}


@end
