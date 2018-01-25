//
//  UIViewController+CallBack.m
//
//  Created by Hamid Farooq on 1/23/18.
//  Copyright © 2018. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "UIViewController+CallBack.h"
#import <objc/runtime.h>
#import <objc/message.h>

static void * UIViewControllerResultBlockKey = &UIViewControllerResultBlockKey;

@implementation UIViewController (CallBack)

void CB_SwizzleInstanceMethod(Class klass, SEL original, SEL replacement) {
    Method originalMethod = class_getInstanceMethod(klass, original);
    Method replacementMethod = class_getInstanceMethod(klass, replacement);
    if(class_addMethod(klass, original, method_getImplementation(replacementMethod), method_getTypeEncoding(replacementMethod)))
        class_replaceMethod(klass, replacement, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    else
        method_exchangeImplementations(originalMethod, replacementMethod);
}

+ (void)load {
    CB_SwizzleInstanceMethod(self, @selector(willMoveToParentViewController:), @selector(CB_willMoveToParentViewController:));
    CB_SwizzleInstanceMethod(self, @selector(didMoveToParentViewController:), @selector(CB_didMoveToParentViewController:));
    CB_SwizzleInstanceMethod(self, @selector(dismissViewControllerAnimated:completion:), @selector(CB_dismissViewControllerAnimated:completion:));
}

- (void)CB_willMoveToParentViewController:(UIViewController *)parent {
    if (parent == nil) { // leaving
        if ([self conformsToProtocol:@protocol(UIViewControllerUnloadCallBackDelegate)]) {
            if (self.resultBlock) {
                id object = nil;
                if ([(id<UIViewControllerUnloadCallBackDelegate>)self respondsToSelector:@selector(viewUnloadWithResultObject)])
                    object = [(id<UIViewControllerUnloadCallBackDelegate>)self viewUnloadWithResultObject];
                    
                self.resultBlock(object);
            }
            if ([(id<UIViewControllerUnloadCallBackDelegate>)self respondsToSelector:@selector(viewWillUnloadCallBack)])
                [(id<UIViewControllerUnloadCallBackDelegate>)self viewWillUnloadCallBack];
        }
    }
    else { // entering
        
    }
}

- (void)CB_didMoveToParentViewController:(UIViewController *)parent {
    if (parent == nil) { // leaving
        if ([self conformsToProtocol:@protocol(UIViewControllerUnloadCallBackDelegate)]) {
            if ([(id<UIViewControllerUnloadCallBackDelegate>)self respondsToSelector:@selector(viewDidUnloadCallBack)])
                [(id<UIViewControllerUnloadCallBackDelegate>)self viewDidUnloadCallBack];
        }
    }
    else { // entering
        
    }
}

- (void)CB_dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    __block UIViewController *viewControllerRef = self;
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)self;
        viewControllerRef = navigationController.viewControllers.firstObject;
    }
    
    [viewControllerRef willMoveToParentViewController:nil];
    [self CB_dismissViewControllerAnimated:flag completion:^{
        [viewControllerRef didMoveToParentViewController:nil];
        if (completion)
            completion();
    }];
}

- (UIViewControllerResultBlock)resultBlock {
    return objc_getAssociatedObject(self, UIViewControllerResultBlockKey);
}

- (void)setResultBlock:(UIViewControllerResultBlock)resultBlock {
    objc_setAssociatedObject(self, UIViewControllerResultBlockKey, resultBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
