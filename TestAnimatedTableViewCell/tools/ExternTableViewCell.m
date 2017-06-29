//
//  ExternTableViewCell.m
//  TestAnimatedTableViewCell
//
//  Created by JianF.Sun on 17/6/28.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import "ExternTableViewCell.h"
#import "UIView+SetCornerRadiusAndBorderLine.h"

static const CGFloat firstHeight = 80;
static const CGFloat secondHeight = 80;
static const CGFloat thirdHeight = 80;
static const CGFloat margin = 10;
static const CGFloat leftSeperatorWidth = 10;

static const CGFloat maxAngle = 2*M_PI_2-0.3;

#define ExternTBLabel_Width  [[UIScreen mainScreen] bounds].size.width

@interface ExternTableViewCell ()

@end

@implementation ExternTableViewCell

#pragma mark - alloc

/*
 高度：firstHeight+secondHeight+thirdHeight+margin*2+1*2
*/
-(instancetype)init{
    self = [super init];
    if (self) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ExternTableViewCell" owner:nil options:nil];
        self = [array lastObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
        
    }
   
    return self;
}



#pragma mark - UI

-(void)setUI{
    
    
    [self hiddenFooterViews];
    
    self.mainView.frame = CGRectMake(leftSeperatorWidth, 0,ExternTBLabel_Width-20-leftSeperatorWidth, firstHeight);
    self.secondView.frame = CGRectMake(leftSeperatorWidth, CGRectGetMaxY(self.mainView.frame)+1, CGRectGetWidth(self.mainView.frame), secondHeight);

    self.ThirdView.frame = CGRectMake(leftSeperatorWidth, CGRectGetMaxY(self.secondView.frame)+1,CGRectGetWidth(self.mainView.frame), thirdHeight);
    self.leftSeperatorView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()% 255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
}

-(void)hiddenFooterViews{
    self.secondView.hidden = YES;
    self.ThirdView.hidden = YES;
    self.InnerView.frame = CGRectMake(margin, margin, ExternTBLabel_Width-2*margin,firstHeight);
   
    self.leftSeperatorView.frame = CGRectMake(0, 0, leftSeperatorWidth, self.InnerView.bounds.size.height);
    [self.InnerView setCornerRadiusWithType:Corner_Radius_Or_BorderLine_All Radius:5];
    NSLog(@"%f",ExternTBLabel_Width);
}
-(void)showFooterViews{
    self.secondView.hidden = NO;
    self.ThirdView.hidden = NO;
    self.InnerView.frame = CGRectMake(margin, margin, ExternTBLabel_Width-2*margin,firstHeight+secondHeight+thirdHeight+1*2);
    self.leftSeperatorView.frame = CGRectMake(0, 0, leftSeperatorWidth, self.InnerView.bounds.size.height);
    [self.InnerView setCornerRadiusWithType:Corner_Radius_Or_BorderLine_All Radius:5];
    
}

#pragma mark -  show && hide

-(void)showListwithTime:(NSArray*)times complection:(ComplectionBlock)complection{
    
    /*
     *
     *第一次动画
     *
     */
    UIView *tmpView = [[UIView alloc]init];
    tmpView.frame = self.secondView.frame;
    [self setShadow:tmpView];
    tmpView.backgroundColor = self.secondView.backgroundColor;
    [self.InnerView addSubview:tmpView];
    [self prepareAnimation:tmpView];
    tmpView.layer.transform=CATransform3DMakeRotation(maxAngle, 1, 0, 0);
    [UIView animateWithDuration:[times[0] floatValue]/2 animations:^{
        
        tmpView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        
    }completion:^(BOOL finished) {
        
        [tmpView removeFromSuperview];
        
        
        /*
         *
         *第二次动画
         *
         */
        [self prepareAnimation:self.secondView];
        
        self.secondView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        
        [UIView animateWithDuration:[times[0] floatValue]/2 animations:^{
            
            self.InnerView.frame = CGRectMake(margin, margin, ExternTBLabel_Width-2*margin,firstHeight+secondHeight+1);
            
            self.leftSeperatorView.frame = CGRectMake(0, 0, leftSeperatorWidth,self.InnerView.bounds.size.height);
            
            [self.InnerView setCornerRadiusWithType:Corner_Radius_Or_BorderLine_UP Radius:5];
            self.secondView.hidden = NO;
            
            self.secondView.layer.transform=CATransform3DMakeRotation(0, 1, 0, 0);
            }completion:^(BOOL finished) {
        
                
                
                /*
                 *
                 *第三次动画
                 *
                 */
                UIView *tmpView = [[UIView alloc]init];
                tmpView.frame = self.ThirdView.frame;
                tmpView.backgroundColor = self.ThirdView.backgroundColor;
                [self setShadow:tmpView];
                [self.InnerView addSubview:tmpView];
                [self prepareAnimation:tmpView];
                tmpView.layer.transform=CATransform3DMakeRotation(maxAngle, 1, 0, 0);
                
                [UIView animateWithDuration:[times[1] floatValue]/2 animations:^{
                    tmpView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                }completion:^(BOOL finished) {
                    [tmpView removeFromSuperview];
                    
                    
                    /*
                     *
                     *第四次动画
                     *
                     */
                    self.ThirdView.hidden = NO;
                    [self prepareAnimation:self.ThirdView];
//                    [self setShadow:self.secondView];
                    self.ThirdView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                    [UIView animateWithDuration:[times[1] floatValue]/2 animations:^{//第4次
                        self.ThirdView.layer.transform=CATransform3DMakeRotation(0, 1, 0, 0);
                        self.InnerView.frame = CGRectMake(margin, margin, ExternTBLabel_Width-2*margin,firstHeight+secondHeight+thirdHeight+1*2);
                        self.leftSeperatorView.frame = CGRectMake(0, 0, leftSeperatorWidth,self.InnerView.bounds.size.height);

                        [self.InnerView setCornerRadiusWithType:Corner_Radius_Or_BorderLine_UP Radius:5];
                    }completion:^(BOOL finished) {
                        
                        
                        [self.InnerView setCornerRadiusWithType:Corner_Radius_Or_BorderLine_All Radius:5];
                        [self animationDidStop:complection];
                    }];
    
                }];
                
            }];
    }];
    
    

}


-(void)hideListwithTime:(NSArray*)times complection:(ComplectionBlock)complection{

    
    /*
     *
     *第一次
     *
     */
    [self prepareAnimation:self.ThirdView];
    

    self.ThirdView.layer.transform=CATransform3DMakeRotation(0, 1, 0, 0);

    [UIView animateWithDuration:[times[0] floatValue]/2 animations:^{
        
        
        self.ThirdView.hidden = NO;
        self.ThirdView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        self.InnerView.frame = CGRectMake(margin, margin, ExternTBLabel_Width-2*margin,firstHeight+secondHeight+1);
        self.leftSeperatorView.frame = CGRectMake(0, 0, leftSeperatorWidth,self.InnerView.bounds.size.height);
    }completion:^(BOOL finished) {

        self.ThirdView.hidden = YES;
        self.ThirdView.layer.transform=CATransform3DMakeRotation(0, 1, 0, 0);
        /*
         *
         *第二次
         *
         */
        UIView *tmpView = [[UIView alloc]init];
        tmpView.frame = self.ThirdView.frame;
        tmpView.backgroundColor = self.ThirdView.backgroundColor;
        [self.InnerView addSubview:tmpView];
        [self prepareAnimation:tmpView];
        tmpView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
        [UIView animateWithDuration:[times[0] floatValue]/2 animations:^{
            
            tmpView.layer.transform=CATransform3DMakeRotation(maxAngle, 1, 0, 0);
            
        }completion:^(BOOL finished) {
        
             [tmpView removeFromSuperview];
            
            /*
             *
             *第三次
             *
             */
            
            [self prepareAnimation:self.secondView];
            self.secondView.layer.transform=CATransform3DMakeRotation(0, 1, 0, 0);
            [UIView animateWithDuration:[times[1] floatValue]/2 animations:^{
                self.secondView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                self.InnerView.frame = CGRectMake(margin, margin, ExternTBLabel_Width-2*margin,firstHeight);
                self.leftSeperatorView.frame = CGRectMake(0, 0, leftSeperatorWidth,self.InnerView.bounds.size.height);
            }completion:^(BOOL finished) {
                
                self.secondView.hidden = YES;
                
                
                self.secondView.layer.transform=CATransform3DMakeRotation(0, 1, 0, 0);
                [self.InnerView setCornerRadiusWithType:Corner_Radius_Or_BorderLine_All Radius:5];
                
                /*
                 *
                 *第四次
                 *
                 */
                UIView *tmpView = [[UIView alloc]init];
                tmpView.frame = self.secondView.frame;
                tmpView.backgroundColor = self.secondView.backgroundColor;
                [self.InnerView addSubview:tmpView];
                [self prepareAnimation:tmpView];
                tmpView.layer.transform=CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                [UIView animateWithDuration:[times[0] floatValue]/2 animations:^{
                    
                    tmpView.layer.transform=CATransform3DMakeRotation(maxAngle, 1, 0, 0);
                    
                }completion:^(BOOL finished) {
                    
                    [tmpView removeFromSuperview];
                     [self animationDidStop:complection];
                    
                }];
                
                
               
            }];
        
        }];
        
    }];
}

#pragma mark - Animation did Stop
-(void)animationDidStop:(ComplectionBlock)complection{
    NSLog(@"Animation did Stop");
    if (complection) {
        complection();
    }
}

#pragma mark - anchor point 

-(void)prepareAnimation:(UIView*)targetView{
    //设置锚点，实现围绕上边界旋转
    [self setAnchorPointTo:CGPointMake(0.5, 0) view:targetView];
    
    //给containView添加偏移
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = -0.002;
    self.InnerView.layer.sublayerTransform = transfrom3d;
}

-(void)setShadow:(UIView*)targetView{
    //阴影
    targetView.layer.shadowOpacity = 1.0;// 阴影透明度
    targetView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    targetView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    targetView.layer.shadowOffset  = CGSizeMake(3, 3);// 阴影的范围
}


- (void)setAnchorPointTo:(CGPoint)point view:(UIView*)view{
    
/*    
 
    CGRect frame = view.frame;
    frame.origin.x+=(point.x - view.layer.anchorPoint.x) * view.frame.size.width;
    frame.origin.y+=(point.y - view.layer.anchorPoint.y) * view.frame.size.height;
    view.frame = frame;
    view.layer.anchorPoint = point;
 
*/
    //和上面注销掉的代码一个意思
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
}


#pragma mark - other 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
