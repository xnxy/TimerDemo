//
//  ViewController.m
//  TimerDemo
//
//  Created by 周伟 on 2017/6/10.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *clickBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickBtn = btn;
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
    
    //layout
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(CGSizeMake(200, 100));
    }];
    
    //action
    @weakify(self)
    [btn bk_whenTapped:^{
        @strongify(self)
        [self timeAnimation];
    }];
    
}

#pragma mark ---
#pragma mark ---- Animation ---
- (void)timeAnimation{
    
    POPBasicAnimation *basicAnimation = [POPBasicAnimation linearAnimation];
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"timeAnimation" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat *values) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitle:[NSString stringWithFormat:@"%d",(int)values[0]%60] forState:UIControlStateNormal];
        };
        
    }];
    
    basicAnimation.property = prop;
    basicAnimation.fromValue = @(10);
    basicAnimation.toValue = @(0);
    basicAnimation.duration = 10;
    
    [self.clickBtn pop_addAnimation:basicAnimation forKey:@"timeAnimation"];
    
    //开始
    basicAnimation.animationDidStartBlock = ^(POPAnimation *anim) {
        self.clickBtn.enabled = NO;
    };
    
    //结束
    basicAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        self.clickBtn.enabled = YES;
        [self.clickBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
