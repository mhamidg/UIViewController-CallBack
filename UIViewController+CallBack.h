//
//  UIViewController+CallBack.h
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


#import <UIKit/UIKit.h>

typedef void (^UIViewControllerResultBlock)(id resultObject);

@interface UIViewController (CallBack)

@property (nonatomic, copy) UIViewControllerResultBlock resultBlock; // Set Result Call back in your Parent ViewController using Child ViewController's Object

@end

@protocol UIViewControllerUnloadCallBackDelegate <NSObject>
@optional
- (id)viewUnloadWithResultObject;   // Implement 'viewUnloadWithResultObject' in Child ViewController then you will get resulting object.
- (void)viewWillUnloadCallBack;     // Implement to get the 'viewWillUnloadCallBack', when we will going to close.
- (void)viewDidUnloadCallBack;      // Implement to get the 'viewDidUnloadCallBack', when we did close.
@end
