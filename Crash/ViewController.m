//
//  ViewController.m
//  Crash
//
//  Created by dzc on 2021/1/30.
//

#import "ViewController.h"
#import "Crash.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bbb = [UIButton buttonWithType:UIButtonTypeCustom];
    [bbb setTitle:@"xxxx" forState:UIControlStateNormal];
    bbb.frame = CGRectMake(100, 100, 100, 40);
    bbb.backgroundColor = [UIColor redColor];
    [self.view addSubview:bbb];
    [bbb addTarget:self action:@selector(xxxx) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSObject new] performSelector:@selector(ffff)];
    Crash *cc = [Crash new];
    [cc xxxxxxx];
    
    
}


@end
