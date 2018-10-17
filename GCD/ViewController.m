//
//  ViewController.m
//  GCDexercise
//
//  Created by 李飞艳 on 2018/10/10.
//  Copyright © 2018年 李飞艳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT);
    //1.并发队列 + 同步任务
    //不开启新线程，在当前线程同步执行
    NSLog(@"syncConcurrentBegin");
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"syncConcurrent1:%d",i);
            NSLog(@"syncConcurrent1---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"syncConcurrent2:%d",i);
            NSLog(@"syncConcurrent2---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"syncConcurrent3:%d",i);
            NSLog(@"syncConcurrent3---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncConcurrentEnd");
    //1.所有任务都在打印的begin和end之间执行的（同步任务需要等待队列的任务执行结束）
    //2.任务按顺序执行(即同步执行)
    
    //2.并发队列 + 异步任务
    //可以开启新的线程，任务交替执行
    NSLog(@"asyncConcurrentBegin");
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"asyncConcurrent1:%d",i);
            NSLog(@"asyncConcurrent1---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"asyncConcurrent2:%d",i);
            NSLog(@"asyncConcurrent2---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"asyncConcurrent3:%d",i);
            NSLog(@"asyncConcurrent3---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncConcurrentEnd");
    //1.任务都在打印asyncConcurrentBegin、asyncConcurrentEnd之后执行
    //2.创建三个新的线程，任务同时交替执行
    
    //串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    //3.同步任务 添加到 串行队列
    //不开启新的线程，任务在当前线程按顺序(即同步)执行
    NSLog(@"syncSerialBegin");
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"syncSerial1:%d",i);
            NSLog(@"syncSerial1---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"syncSerial2:%d",i);
            NSLog(@"syncSerial2---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"syncSerial3:%d",i);
            NSLog(@"syncSerial3---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"syncSerialEnd");
    //1.任务都在打印syncSerialBegin、syncSerialEnd之间执行
    //2.不开启新线程，任务按顺序执行(即同步执行)(同步任务故不能开启新线程)
    
    //4.异步任务 添加到 串行队列
    //开启一个新线程，按顺序(即同步)执行任务
    NSLog(@"asyncSerialBegin");
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"asyncSerial1:%d",i);
            NSLog(@"syncSerial1---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"asyncSerial2:%d",i);
            NSLog(@"asyncSerial2---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"asyncSerial3:%d",i);
            NSLog(@"asyncSerial3---%@",[NSThread currentThread]);
        }
    });
    NSLog(@"asyncSerialEnd");
    //1.任务都在打印asyncSerialBegin、asyncSerialEnd之后执行
    //2.创建一个新的线程(异步任务具有创建新线程的能力，串行队列)，任务按顺序依次执行(串行队列中的任务只能同步执行)
    
    /**
     *线程通信
     *栅栏
     */
}

@end
