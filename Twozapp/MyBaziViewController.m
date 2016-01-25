//
//  MyBaziViewController.m
//  Twozapp
//
//  Created by Priya on 21/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "MyBaziViewController.h"
#import "UserDetails.h"

@interface MyBaziViewController ()

@end

@implementation MyBaziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnDragan.layer.cornerRadius = 7.0;
    [_btnDragan. layer setMasksToBounds:YES];
    _btnOx.layer.cornerRadius = 7.0;
    [_btnOx. layer setMasksToBounds:YES];
    _btnHorse.layer.cornerRadius = 7.0;
    [_btnHorse. layer setMasksToBounds:YES];
    _btnSnake.layer.cornerRadius = 7.0;
    [_btnSnake. layer setMasksToBounds:YES];
    
    _view1.layer.cornerRadius = 7.0;
    [_view1. layer setMasksToBounds:YES];
    _view2.layer.cornerRadius = 7.0;
    [_view2. layer setMasksToBounds:YES];
    _view3.layer.cornerRadius = 7.0;
    [_view3. layer setMasksToBounds:YES];
    _view4.layer.cornerRadius = 7.0;
    [_view4. layer setMasksToBounds:YES];
    _view5.layer.cornerRadius = 7.0;
    [_view5. layer setMasksToBounds:YES];
    _view6.layer.cornerRadius = 7.0;
    [_view6. layer setMasksToBounds:YES];
    _view7.layer.cornerRadius = 7.0;
    [_view7. layer setMasksToBounds:YES];
    _view8.layer.cornerRadius = 7.0;
    [_view8. layer setMasksToBounds:YES];
    
    
    
    
    _lblName.text = [UserDetails sharedInstance].full_name;
    if ([[UserDetails sharedInstance].gender isEqualToString:@"2"])
         _lblGender.text = @"Female";
    else
        _lblGender.text = @"male";
    
    if ([[UserDetails sharedInstance].chinese_element isEqualToString:@"water_wood"]) {
        _view2.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
