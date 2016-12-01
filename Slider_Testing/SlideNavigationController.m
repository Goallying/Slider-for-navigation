//
//  SlideNavigationController.m
//  Slider_Testing
//
//  Created by 万存 on 16/3/31.
//  Copyright © 2016年 WanCun. All rights reserved.
//

#import "SlideNavigationController.h"

@interface SlideNavigationController ()<UINavigationControllerDelegate>

@end

@implementation SlideNavigationController

+(SlideNavigationController *)sharedInstance{
    static SlideNavigationController * sharedInstance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance =[[SlideNavigationController alloc] init];
    });
    return sharedInstance;
    
}
//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    return  [SlideNavigationController sharedInstance] ;
//}
-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setUp] ;
    }
    return self ;
}
-(instancetype) init{
    if (self = [super init]) {
        [self setUp];
    }
    return self ;
}
-(void)setUp{
    self.delegate = self ;
    self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.view.layer.shadowRadius = 10;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    self.view.layer.shadowOpacity = 1;
    self.view.layer.shouldRasterize = YES;
    self.view.layer.rasterizationScale = [UIScreen mainScreen].scale ;
}
-(UIBarButtonItem *)leftBarbuttonItem{
    if (!_leftBarbuttonItem) {
        UIImage * image = [UIImage imageNamed:@"menu-button"];
        _leftBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftMenuClick:)];
    }
    return _leftBarbuttonItem;
}
-(void) leftMenuClick:(UIBarButtonItem *)item {
    if ([self isMenuOpen] == NO) {
        [self closeMenuWithCompletionBlock:nil] ;
    }else{
        [self openMenuWthComPletionBlock:nil] ;
    }
    
}
-(BOOL)isMenuOpen{
    return self.view.frame.origin.x == 0;
}
-(void)closeMenuWithCompletionBlock: (void(^)())completion{
    [self closeMenuWithDuration:0.2 andCompletion:completion] ;
}
-(void)closeMenuWithDuration:(CGFloat)duration andCompletion:(void(^)())completion{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            CGRect rect = self.view.frame ;
                            rect.origin.x = 0 ;
                            self.view.frame = rect ;
                        } completion:^(BOOL finished) {
                            if (completion) {
                                completion();
                            }
                        }];
    
}
-(void)openMenuWthComPletionBlock:(void(^)())completion{
    [self openMenuWithDuration:0.2 andCompletion:completion] ;
}
-(void)openMenuWithDuration:(CGFloat)duration andCompletion:(void(^)())completion{
    
    [self.view.window insertSubview:self.leftMenu.view atIndex:0];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect rect = self.view.frame ;
                         rect.origin.x =rect.size.width / 2 ;
                         self.view.frame = rect;
                     } completion:^(BOOL finished) {
                         if (completion) {
                             completion() ;
                         }
                     }];
}
#pragma mark - UINavigationControllerDelegate Methods -
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.navigationItem.leftBarButtonItem = self.leftBarbuttonItem;
}

@end
