//
//  ViewController.m
//  Example
//
//  Created by Hamid Farooq on 1/28/18.
//

#import "ViewController.h"
#import "UIViewController+CallBack.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushViewController:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
    [controller setResultBlock:^(id resultObject) {
        NSLog(@"New View Controller did pop and resulting object is: %@", resultObject);
    }];
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)presentViewController:(id)sender {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewViewController"];
    [controller setResultBlock:^(id resultObject) {
        NSLog(@"New View Controller did dismissed and resulting object is: %@", resultObject);
    }];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self.navigationController presentViewController:navController animated:YES completion:NULL];
}

@end
