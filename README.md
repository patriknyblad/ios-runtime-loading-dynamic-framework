# Dynamically link code at runtime

This sample project shows how to link code at runtime in Objective-C building for iOS. A step by step guide on what I did to create this sample project is available below.


### Why?

Well the reason for me was simple. I wanted to test out different versions of the same framework in my app and switch between them in runtime for regression testing with the QA team. Another good thing is that your app can load faster if your framework is huge and is not used directly at start up.

### Learnings

The functions in the objective c runtime for loading frameworks are really powerful, have a look at this header file to see the documentation for the different methods: `#import "dlfcn.h"`.

Loading code using `dlopen()` seems to work fine but unloading code using `dlclose()`is not really supported on iOS. Therefore this solution cannot be used to switch out different versions of the same external framework/library at runtime. However you can choose what framework/library you want to load once and you could let your users restart the app to choose another library configuration.

This didn't fulfill all my dreams but it came really close. The QA team now has to restart the app (so that the framework is not loaded any more) to choose another version of the framework for testing.


### What I did, step by step
##### Setup the app
1 Singleview app

2 Create new targets (CocoaTouchFramework) dynamic-library-1 & dynamic-library-2

3 Create 2 CASHello classes

4 Add each CASHello class to each dynamic lib target in `compile sources`


#####Make the frameworks not link on startup

5 Remove frameworks from app target `General` page

6 #import "dlfcn.h"

7 Add both frameworks as target dependencies to app (to make them build)

8 Add a new `Copy Files` build phase configured for `Frameworks` destination

8 Add both frameworks to the new `Copy Files` Build Phase to have them packed and signed together with your app