//
//  ZTabBarViewController.m
//  移动显示TabBar
//
//  Created by qingLiang on 16/11/8.
//  Copyright (c) 2016年 itcast. All rights reserved.
//

#import "ZTabBarViewController.h"
#import "ZTableViewController.h"

@interface ZTabBarViewController ()

@end

@implementation ZTabBarViewController

+ (instancetype)shareTabBar
{
    static ZTabBarViewController *tabbarController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbarController = [[self alloc] init];
    });
    return tabbarController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ZTableViewController *tableView = [[ZTableViewController alloc] init];
    [self addController:tableView image:@"home_normal" selectImage:@"home_highlight" title:@"首页"];
}

- (void)addController:(UIViewController *)controller image:(NSString *)imageString selectImage:(NSString *)selectImage title:(NSString *)title
{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageString];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    ZNavViewController *nav = [[ZNavViewController alloc] initWithRootViewController:controller];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
