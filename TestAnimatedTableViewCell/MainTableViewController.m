//
//  MainTableViewController.m
//  TestAnimatedTableViewCell
//
//  Created by JianF.Sun on 17/6/28.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import "MainTableViewController.h"
#import "ExternTableViewCell.h"
@interface MainTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@property(nonatomic,strong) NSMutableArray *isShowListArr;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mainTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (UIImage *)imageFromView:(UIView *)snapView {
    UIGraphicsBeginImageContext(snapView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}

-(NSMutableArray*)isShowListArr{
    if (!_isShowListArr) {
        [self resetisShowListArr];
    }
    return _isShowListArr;
}

-(void)resetisShowListArr{
    self.isShowListArr = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isShowListArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return ([self.isShowListArr[indexPath.row] isEqual:@"0"])?(80+10*2):(80+80+80+10*2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExternTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jfscalecell"];
    
    if (cell==nil) {
        cell = [[ExternTableViewCell alloc]init];
    }
    
    
    //判断是否隐藏
    if ([self.isShowListArr[indexPath.row] isEqualToString:@"1"]) {
        [cell showFooterViews];
    }else{
        [cell hiddenFooterViews];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExternTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    
    NSArray * times = @[@.3,@.3];
    
    if ([self.isShowListArr[indexPath.row] isEqualToString:@"0"]) {
        self.isShowListArr[indexPath.row] = @"1";
        [selectedCell showListwithTime:times complection:nil];
        
    }else{
        
        self.isShowListArr[indexPath.row] = @"0";
        [selectedCell hideListwithTime:times complection:nil];
    }
    
    [UIView animateWithDuration:[times[0] floatValue]+[times[1] floatValue] animations:^{
        
        [tableView beginUpdates];
        [tableView endUpdates];
        
    } completion:nil];
}

@end
