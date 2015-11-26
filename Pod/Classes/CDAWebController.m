//
//  CDAWebController.m
//
//  Created by Boris Bügling on 11/06/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <objc/runtime.h>

#import "CDAWebController.h"
#import "UIView+Geometry.h"

@interface CDAWebController ()

@property CGFloat originalHeight;
@property UIView* overlayView;

@end

#pragma mark -

@implementation CDAWebController

+(UIViewController*)pushWebControllerForURL:(NSURL*)url
                     toNavigationController:(UINavigationController*)parent {
    Class safariViewController = objc_getClass("SFSafariViewController");
    UIViewController* controller = nil;

    if (safariViewController) {
        controller = [[safariViewController alloc] initWithURL:url];
        [parent pushViewController:controller animated:YES];
    } else {
        controller = [[[self class] alloc] initWithURL:url];
        [parent pushViewController:controller animated:YES];
    }

    return controller;
}

#pragma mark -

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];

    self.originalHeight = 0.0;
    [self updateFrames];
}

-(id)initWithURL:(NSURL *)url {
    self = [super initWithURL:url];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.hideTopBarAndBottomBarOnScrolling = NO;
        self.mode = TSMiniWebBrowserModeNavigation;
        self.showPageTitleOnTitleBar = NO;
        self.showToolBar = NO;
    }
    return self;
}

-(void)updateFrames {
    if (self.originalHeight == 0.0) {
        self.originalHeight = self.view.height;
    }

    self.view.y = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? 20.0 : -12.0;
    self.view.height = self.originalHeight + 40.0;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.overlayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.overlayView];
}

#pragma UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)_webView {
    [super webViewDidFinishLoad:_webView];

    [self.overlayView removeFromSuperview];
    self.overlayView = nil;

    [self updateFrames];
}

@end
