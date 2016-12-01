//
//  UINavigationController+Slider.m
//  Slider_Testing
//
//  Created by zhulaifei on 16/11/30.
//  Copyright © 2016年 WanCun. All rights reserved.
//

#import "UINavigationController+Slider.h"

#import <objc/runtime.h>
static NSString * const UINavigationKey = @"UINavigationKey" ;
static NSString * const UINavigationBarItemKey = @"UINavigationBarItemKey" ;
@interface UINavigationController()<UINavigationControllerDelegate>



@end

@implementation UINavigationController (Slider)

-(UIViewController *)leftMenu{
    return objc_getAssociatedObject(self, &UINavigationKey) ;
}
-(void)setLeftMenu:(UIViewController *)leftMenu{
    objc_setAssociatedObject(self, &UINavigationKey, leftMenu, OBJC_ASSOCIATION_RETAIN) ;
    
}
-(UIBarButtonItem *)leftbarButtonItem{
    
    return objc_getAssociatedObject(self, &UINavigationBarItemKey) ;
}
-(void)setLeftbarButtonItem:(UIBarButtonItem *)leftbarButtonItem{
    objc_setAssociatedObject(self, &UINavigationBarItemKey, leftbarButtonItem, OBJC_ASSOCIATION_RETAIN) ;

}


-(void)viewDidLoad{
    [super viewDidLoad] ;
    [self setup] ;
}

-(void)setup{
    
    self.delegate = self;
    
    self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.view.layer.shadowRadius = 10;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    self.view.layer.shadowOpacity = 1;
    self.view.layer.shouldRasterize = YES;
    self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
}
#pragma mark - UINavigationControllerDelegate Methods -
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    Class cls = NSClassFromString(@"ViewController1") ;
    if ([viewController isKindOfClass:[cls class]]) {
        UIImage * image = [UIImage imageNamed:@"menu-button"];
        UIBarButtonItem *leftBarbuttonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftMenuClick:)];
        viewController.navigationItem.leftBarButtonItem = leftBarbuttonItem ;
    }
    
  
}
-(void)leftMenuClick :(UIBarButtonItem *)item{
    if ([self isMenuOpen]  == NO) {
        [self closeMenuWithCompletionBlock:nil] ;
    }else{
        [self openMenuWthComPletionBlock:nil] ;
    }
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
-(BOOL)isMenuOpen{
    return self.view.frame.origin.x == 0;
}

@end
