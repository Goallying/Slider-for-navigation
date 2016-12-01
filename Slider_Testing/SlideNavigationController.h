//
//  SlideNavigationController.h
//  Slider_Testing
//
//  Created by 万存 on 16/3/31.
//  Copyright © 2016年 WanCun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideNavigationController : UINavigationController


@property (nonatomic ,strong) UIViewController *leftMenu ;
@property (nonatomic ,strong) UIBarButtonItem  *leftBarbuttonItem ;

+(SlideNavigationController *)sharedInstance;
@end
