//
//  ZTableViewController.m
//  移动显示TabBar
//
//  Created by qingLiang on 16/11/8.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "ZTableViewController.h"


#define SCREENWIDTHa  [UIScreen mainScreen].bounds.size.width
#define imageH        200
@interface ZTableViewController ()

@property(nonatomic,strong) UIImageView *imageBG;
@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) NSIndexPath *indexPath;

@end

@implementation ZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.view addSubview:self.imageBG];

    self.tableView.contentInset = UIEdgeInsetsMake(imageH, 0, 0, 0);
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.navigationItem.titleView = self.titleLabel;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor = [UIColor purpleColor];
    cell.textLabel.text = [NSString stringWithFormat:@"text--%tu",indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.indexPath == indexPath) {
        return 120;
    }
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [tableView beginUpdates];
//    [tableView endUpdates];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = imageH + offsetY;
    if (offsetH < 0) {
        CGRect frame = self.imageBG.frame;
        frame.size.height = imageH - offsetH;
        frame.origin.y = -imageH + offsetH;
        self.imageBG.frame = frame;
        self.titleLabel.alpha = 0;
    }
    
    
    
    CGFloat alpha = offsetH / imageH;
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.titleLabel.alpha = alpha;
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [UIView animateWithDuration:1 animations:^{
//        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
//        [UIView animateWithDuration:5 animations:^{
//            self.navigationController.navigationBar.alpha = 0;
//        }];
//    }];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [UIView animateWithDuration:1 animations:^{
        self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
        self.navigationController.navigationBar.alpha = 1;
    }];
}

/**
 *  返回一张纯色图片
 *
 *  @param color 颜色
 *
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - lazy
- (UIImageView *)imageBG
{
    if (_imageBG == nil) {
        _imageBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1111"]];
        _imageBG.frame = CGRectMake(0, -imageH, SCREENWIDTHa, imageH );
        _imageBG.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageBG;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"首页";
        _titleLabel.frame = CGRectMake(0, 0, SCREENWIDTHa, 64);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0;
    }
    return _titleLabel;
}

@end
