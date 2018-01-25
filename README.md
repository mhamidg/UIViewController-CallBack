# UIViewController-CallBack
Call back methods, which will trigger on same UIViewController close along with send result object to the parent view controller automatically.


Just inherit "UIViewControllerUnloadCallBackDelegate" protocol to your ViewController and you will receive call back methods:

- (id)viewUnloadWithResultObject;
Implement "viewUnloadWithResultObject" in your ViewController then you will get call this method to return the resulting object.

To get back the resulting object in parent view controller you need to set "resultBlock" from parent ViewController using child ViewController object.

- (void)viewWillUnloadCallBack;
// Implement "viewWillUnloadCallBack" in your ViewController to get back this method call when ViewController will unload.

- (void)viewDidUnloadCallBack;
// Implement "viewDidUnloadCallBack" in your ViewController to get back this method call when ViewController did unload. it will call before dealloc method.


Example: How to get back result object in parent ViewController


Set this resultBlock in your Parent ViewController

UIViewController *viewController = [[UIViewController alloc] init];
[viewController setResultBlock:^(id resultObject) {
    NSLog(@"Result object: %@", resultObject);
}];


Override this method in your child ViewController

- (id)viewUnloadWithResultObject {
    return anyObject;
}

That's if! :)