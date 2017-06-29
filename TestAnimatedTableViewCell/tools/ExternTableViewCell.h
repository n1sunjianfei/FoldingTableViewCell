//
//  ExternTableViewCell.h
//  TestAnimatedTableViewCell
//
//  Created by JianF.Sun on 17/6/28.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ComplectionBlock)(void);
@interface ExternTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *InnerView;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *ThirdView;
@property (weak, nonatomic) IBOutlet UIView *leftSeperatorView;

-(void)showListwithTime:(NSArray*)times complection:(ComplectionBlock)complection;
-(void)hideListwithTime:(NSArray*)times complection:(ComplectionBlock)complection;

-(void)hiddenFooterViews;
-(void)showFooterViews;
@end
