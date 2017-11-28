//
//  ZEDImageDownloader.h
//  ZEDAsyncOperationDemo
//
//  Created by 李超 on 2017/11/28.
//  Copyright © 2017年 ZED. All rights reserved.
//

#import "ZEDAsyncOperation.h"

@interface ZEDImageDownloader : ZEDAsyncOperation

- (instancetype)initWithImageURL:(NSString *)url;

@end
