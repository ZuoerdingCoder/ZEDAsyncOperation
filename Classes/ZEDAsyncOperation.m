//
//  ZEDAsyncOperation.m
//  ZEDAsyncOperationDemo
//
//  Created by 李超 on 2017/11/28.
//  Copyright © 2017年 ZED. All rights reserved.
//

#import "ZEDAsyncOperation.h"

typedef NS_ENUM(char, ZEDAsyncOperationState) {
    ZEDAsyncOperationStateReady,
    ZEDAsyncOperationStateExecuting,
    ZEDAsyncOperationStateFinished
};

static inline NSString *DRKeyPathFromAsyncOperationState(ZEDAsyncOperationState state) {
    switch (state) {
            case ZEDAsyncOperationStateReady:        return @"isReady";
            case ZEDAsyncOperationStateExecuting:    return @"isExecuting";
            case ZEDAsyncOperationStateFinished:     return @"isFinished";
    }
}

@interface ZEDAsyncOperation ()

@property(nonatomic, assign) ZEDAsyncOperationState state;
@property(nonatomic, strong, readonly) dispatch_queue_t dispatchQueue;

@end

@implementation ZEDAsyncOperation

#pragma mark -
#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *identifier = [NSString stringWithFormat:@"com.dmcrodrigues.%@(%p)", NSStringFromClass(self.class), self];
        
        _dispatchQueue = dispatch_queue_create([identifier UTF8String], DISPATCH_QUEUE_SERIAL);
        
        dispatch_queue_set_specific(_dispatchQueue, (__bridge const void *)(_dispatchQueue),
                                    (__bridge void *)(self), NULL);
    }
    return self;
}

#pragma mark -
#pragma mark NSOperation methods

#if defined(__IPHONE_OS_VERSION_MIN_ALLOWED) && __IPHONE_OS_VERSION_MIN_ALLOWED >= __IPHONE_7_0
- (BOOL)isAsynchronous
{
    return YES;
}
#endif

#if defined(__IPHONE_OS_VERSION_MIN_ALLOWED) && __IPHONE_OS_VERSION_MIN_ALLOWED < __IPHONE_7_0
- (BOOL)isConcurrent
{
    return YES;
}
#endif

- (BOOL)isExecuting
{
    __block BOOL isExecuting;
    
    [self performBlockAndWait:^{
        isExecuting = self.state == ZEDAsyncOperationStateExecuting;
    }];
    
    return isExecuting;
}

- (BOOL)isFinished
{
    __block BOOL isFinished;
    
    [self performBlockAndWait:^{
        isFinished = self.state == ZEDAsyncOperationStateFinished;
    }];
    
    return isFinished;
}

- (void)start
{
    @autoreleasepool {
        
        if ([self isCancelled]) {
            [self finish];
            return;
        }
        
        __block BOOL isExecuting = YES;
        
        [self performBlockAndWait:^{
            
            // Ignore this call if the operation is already executing or if has finished already
            if (self.state != ZEDAsyncOperationStateReady) {
                isExecuting = NO;
            }
            else {
                // Signal the beginning of operation
                self.state = ZEDAsyncOperationStateExecuting;
            }
        }];
        
        if (isExecuting) {
            // Execute async task
            [self asyncTask];
        }
    }
}

#pragma mark -
#pragma mark ZEDAsyncOperation methods

- (void)setState:(ZEDAsyncOperationState)state
{
    [self performBlockAndWait:^{
        
        NSString *oldStateKey = DRKeyPathFromAsyncOperationState(_state);
        NSString *newStateKey = DRKeyPathFromAsyncOperationState(state);
        
        [self willChangeValueForKey:oldStateKey];
        [self willChangeValueForKey:newStateKey];
        
        _state = state;
        
        [self didChangeValueForKey:newStateKey];
        [self didChangeValueForKey:oldStateKey];
        
    }];
}

#pragma mark Protected methods

- (void)asyncTask
{
    [self finish];
}

- (void)finish
{
    [self performBlockAndWait:^{
        // Signal the completion of operation
        if (self.state != ZEDAsyncOperationStateFinished) {
            self.state = ZEDAsyncOperationStateFinished;
        }
    }];
}

#pragma mark - Dispatch Queue

- (void)performBlockAndWait:(dispatch_block_t)block {
    void *context = dispatch_get_specific((__bridge const void *)(self.dispatchQueue));
    BOOL runningInDispatchQueue = context == (__bridge void *)(self);
    
    if (runningInDispatchQueue) {
        block();
    } else {
        dispatch_sync(self.dispatchQueue, block);
    }
}


@end
