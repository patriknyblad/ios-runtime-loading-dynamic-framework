//
//  ViewController.m
//  ios-dynamic-loading-framework
//
//  Created by Patrik Nyblad on 18/05/16.
//  Copyright © 2016 CarmineStudios. All rights reserved.
//

#import "ViewController.h"
#import "dlfcn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Loading the first dynamic library here works fine :)
    NSLog(@"Before referencing CASHello in DynamicFramework1");
    [self loadCASHelloFromDynamicFramework1];
    
    /*
     Loading the second framework will give a message in the console saying that both classes will be loaded and referencing the class will result in undefined behavior.
     
     objc[5074]: Class CASHello is implemented in both /private/var/containers/Bundle/Application/1688AD11-CA2A-44F5-9E98-AC1C7495B569/ios-dynamic-loading-framework.app/Frameworks/DynamicFramework1.framework/DynamicFramework1 and /private/var/containers/Bundle/Application/1688AD11-CA2A-44F5-9E98-AC1C7495B569/ios-dynamic-loading-framework.app/Frameworks/DynamicFramework2.framework/DynamicFramework2. One of the two will be used. Which one is undefined.
    */
    NSLog(@"Before referencing CASHello in DynamicFramework2");
    [self loadCASHelloFromDynamicFramework2];
}

-(void)loadCASHelloFromDynamicFramework1
{
    void *framework1Handle = dlopen("DynamicFramework1.framework/DynamicFramework1", RTLD_LAZY);
    
    if (NSClassFromString(@"CASHello"))
    {
        NSLog(@"Loaded CASHello in DynamicFramework1");
    }
    else
    {
        NSLog(@"Could not load CASHello in DynamicFramework1");
    }
    
    dlclose(framework1Handle);
    
    if (NSClassFromString(@"CASHello"))
    {
        NSLog(@"CASHello from DynamicFramework1 still loaded after dlclose()");
    }
    else
    {
        NSLog(@"Unloaded DynamicFramework1");
    }
}

-(void)loadCASHelloFromDynamicFramework2
{
    void *framework1Handle = dlopen("DynamicFramework2.framework/DynamicFramework2", RTLD_LAZY);
    
    if (NSClassFromString(@"CASHello"))
    {
        NSLog(@"Loaded CASHello in DynamicFramework2");
    }
    else
    {
        NSLog(@"Could not load CASHello in DynamicFramework2");
    }
    
    dlclose(framework1Handle);
    
    if (NSClassFromString(@"CASHello"))
    {
        NSLog(@"CASHello from DynamicFramework2 still loaded after dlclose()");
    }
    else
    {
        NSLog(@"Unloaded DynamicFramework2");
    }
}

@end
