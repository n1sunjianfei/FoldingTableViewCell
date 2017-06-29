//
//  UIView+SetCornerRadius.h
//  TestCorner
//
//  Created by JianF.Sun on 17/6/7.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSUInteger{
    
    Corner_Radius_Or_BorderLine_All=0,
    Corner_Radius_Or_BorderLine_UP,
    Corner_Radius_Or_BorderLine_RIGHT,
    Corner_Radius_Or_BorderLine_DOWN,
    Corner_Radius_Or_BorderLine_LEFT,
}Corner_Radius_Or_BorderLine_TYPE;


@interface UIView (SetCornerRadiusAndBorderLine)

/*
 
 1.设置单边圆角时无法进行borderLine的设置，因为此时borderline会被蒙版遮挡一部分；
 
 2.四个角圆角时可以同时设置圆角和borderline，此时就是常规的圆角边线的设置方式
 
 3.用法：直接或者间接继承自UIView的视图都可以进行设置
 

 */

//圆角
-(void)setCornerRadiusWithType:(Corner_Radius_Or_BorderLine_TYPE)type Radius:(CGFloat)cornerradius;

//边线borderline
-(void)drawBorderLineWithType:(Corner_Radius_Or_BorderLine_TYPE)type lineWidth:(CGFloat)lineWidth lineColor:(UIColor*)lineColor;

@end
