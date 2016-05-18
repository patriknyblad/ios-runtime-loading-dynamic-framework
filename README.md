# Dynamically link code at runtime

This sample project shows how to link code at runtime in Objective-C building for iOS. A step by step guide on what I did to create this sample project is available below.


### Why?

Well the reason for me was simple. I wanted to test out different versions of the same framework in my app and switch between them in runtime for regression testing with the QA team. Another good thing is that your app can load faster if your framework is huge and is not used directly at start up.

### Learnings

The functions in the objective c runtime for loading frameworks are really powerful, have a look at this header file to see the documentation for the different methods: `#import "dlfcn.h"`.

Loading code using `dlopen()` seems to work fine but unloading code using `dlclose()`is not really supported on iOS. Therefore this solution cannot be used to switch out different versions of the same external framework/library at runtime. However you can choose what framework/library you want to load once and you could let your users restart the app to choose another library configuration.

This didn't fulfill all my dreams but it came really close. The QA team now has to restart the app (so that the framework is not loaded any more) to choose another version of the framework for testing.


### Sample console output
```
2016-05-18 14:14:33.681 ios-dynamic-loading-framework[5091:2982699] App started
2016-05-18 14:14:33.688 ios-dynamic-loading-framework[5091:2982699] Before referencing CASHello in DynamicFramework1
2016-05-18 14:14:33.800 ios-dynamic-loading-framework[5091:2982699] Loading CASHello in dynamic-framework-1
2016-05-18 14:14:33.801 ios-dynamic-loading-framework[5091:2982699] Loaded CASHello in DynamicFramework1
2016-05-18 14:14:33.801 ios-dynamic-loading-framework[5091:2982699] CASHello from DynamicFramework1 still loaded after dlclose()
2016-05-18 14:14:33.801 ios-dynamic-loading-framework[5091:2982699] Before referencing CASHello in DynamicFramework2
objc[5091]: Class CASHello is implemented in both /private/var/containers/Bundle/Application/24368C92-7299-4B23-8553-870C235265C4/ios-dynamic-loading-framework.app/Frameworks/DynamicFramework1.framework/DynamicFramework1 and /private/var/containers/Bundle/Application/24368C92-7299-4B23-8553-870C235265C4/ios-dynamic-loading-framework.app/Frameworks/DynamicFramework2.framework/DynamicFramework2. One of the two will be used. Which one is undefined.
2016-05-18 14:14:33.857 ios-dynamic-loading-framework[5091:2982699] Loading CASHello in dynamic-framework-2
2016-05-18 14:14:33.857 ios-dynamic-loading-framework[5091:2982699] Loaded CASHello in DynamicFramework2
2016-05-18 14:14:33.857 ios-dynamic-loading-framework[5091:2982699] CASHello from DynamicFramework2 still loaded after dlclose()
```


### What I did, step by step
##### Setup the app
1 Singleview app

2 Create new targets (CocoaTouchFramework) DynamicFramework1 & DynamicFramework2

3 Create CASHello classes for each dynamic framework

4 Add each CASHello class to each dynamic framework target in `compile sources`


#####Make the frameworks not link on startup

5 Remove frameworks from app target `General` page

6 Add both frameworks as target dependencies to app (to make them build)

7 Add a new `Copy Files` build phase configured to store files to the `Frameworks` destination

8 Add both frameworks to the new `Copy Files` Build Phase to have them packed and signed together with your app

9 #import "dlfcn.h"

10 Use dlload ex. `dlload("DynamicFramework1.framework/DynamicFramework1", RTLD_LAZY)` to load a framework at runtime.