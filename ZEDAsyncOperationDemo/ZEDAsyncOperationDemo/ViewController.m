//
//  ViewController.m
//  ZEDAsyncOperationDemo
//
//  Created by 李超 on 2017/11/28.
//  Copyright © 2017年 ZED. All rights reserved.
//

#import "ViewController.h"
#import "ZEDImageDownloader.h"

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)done:(UIBarButtonItem *)sender {
    for (NSInteger i = 0; i < 10; i++) {
        ZEDImageDownloader *downloader = [[ZEDImageDownloader alloc] initWithImageURL:@"http://d.hiphotos.baidu.com/image/h%3D300/sign=8bc5c1cca6c3793162688029dbc5b784/a1ec08fa513d2697aadb0b975cfbb2fb4216d8f4.jpg"];
        [self.operationQueue addOperation:downloader];
    }
}


#pragma mark - Getter
- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 6;
    }
    return _operationQueue;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
