//
//  NewViewController.m
//  Example
//
//  Created by Hamid Farooq on 1/28/18.
//

#import "NewViewController.h"
#import "UIViewController+CallBack.h"

@interface NewViewController () <UIViewControllerUnloadCallBackDelegate>

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)viewUnloadWithResultObject {
    return @"Can Return Any Object";
}

- (void)viewWillUnloadCallBack {
    NSLog(@"NewViewController %@", NSStringFromSelector(_cmd));
}

- (void)viewDidUnloadCallBack {
    NSLog(@"NewViewController %@", NSStringFromSelector(_cmd));
}

- (IBAction)close:(id)sender {
    if (self.navigationController.viewControllers.count > 1)
        [self.navigationController popViewControllerAnimated:YES];
    else
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

@end
