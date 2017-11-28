//
//  ZEDImageDownloader.m
//  ZEDAsyncOperationDemo
//
//  Created by 李超 on 2017/11/28.
//  Copyright © 2017年 ZED. All rights reserved.
//

#import "ZEDImageDownloader.h"
#import "ZEDAsyncOperationSubclass.h"

@interface ZEDImageDownloader ()

@property (nonatomic, strong) NSString *url;

@end

@implementation ZEDImageDownloader

- (instancetype)initWithImageURL:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

#warning ZEDAsyncOperation的子类调用asyncTask方法
- (void)asyncTask {
    
    NSLog(@"*************************");
    
    for (NSInteger i = 0; i<100; i++) {
        NSLog(@"i = %@",@(i));
    }
    [self finish];
}

@end
