//
//  ZEDAsyncOperation.h
//  ZEDAsyncOperationDemo
//
//  Created by 李超 on 2017/11/28.
//  Copyright © 2017年 ZED. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 The \c ZEDAsyncOperation is an abstract class to encapsulate and manage execution of an asynchronous task in a very
 similar way as a common \c NSOperation. Because it is abstract, this class should not be used directly but instead
 subclass to implement the asynchronous task.
 
 To subclass and implement an async task please refer to \c ZEDAsyncOperationSubclass.
 */

@interface ZEDAsyncOperation : NSOperation

@end
