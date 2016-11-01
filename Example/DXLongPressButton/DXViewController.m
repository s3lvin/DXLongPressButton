//
//  DXViewController.m
//  DXLongPressButton
//
//  Created by Selvin Jeyasigamani on 11/01/2016.
//  Copyright (c) 2016 Selvin Jeyasigamani. All rights reserved.
//

#import "DXViewController.h"
#import "UIView+Toast.h"
#import <DXLongPressButton/DXLongPressButton.h>

@interface DXViewController ()

@property (weak, nonatomic) IBOutlet DXLongPressButton *button;

@end

@implementation DXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.button addTarget:nil action:@selector(longPressAction:event:) forControlEvents:UIControlEventLongPress];
    [self.button addTarget:nil action:@selector(normalPressAction:event:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - events -

- (void)longPressAction:(DXLongPressButton *)sender event:(UIEvent *)event {
    [self.view makeToast:@"Long press!"];
}

- (void)normalPressAction:(DXLongPressButton *)sender event:(UIEvent *)event {
    [self.view makeToast:@"Normal press (touchUpInside)"];
}

@end
