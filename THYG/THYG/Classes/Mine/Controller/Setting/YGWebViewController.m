//
//  YGWebViewController.m
//  YaloGame
//
//  Created by C on 2018/11/18.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGWebViewController.h"
#import <WebKit/WebKit.h>

@interface YGWebViewController () <WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation YGWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    if (!YGInfo.validString(self.loadUrl)) {
        if (YGInfo.validString(self.loadContent)) {
            [_webView loadHTMLString:[self fixImagesInHtmlString:self.loadContent] baseURL:nil];
        } else {
            [THHUDProgress showMsg:@"加载出错"];
            if (self.navigationController) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }
        return;
    }
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15]];
    [THHUDProgress show];
}

- (void)setUp {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    NSString *appUserAgent = @"MMApp/1.0.0 NetType/WIFI Language/zh_CN(MM iOS APP/1.0)";
//    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError * _Nullable error) {
//        NSString *userAgent = result;
//        NSString *newUserAgent = [userAgent stringByAppendingString:appUserAgent];
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
//    }];
//    if (@available(iOS 9.0, *)) {
//        _webView.customUserAgent = userAgent;
//    } else {
//        NSDictionary *dic = @{@"UserAgent":userAgent};
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
//    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.navigationItem.title = change[NSKeyValueChangeNewKey];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [THHUDProgress dismiss];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [THHUDProgress dismiss];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
     [THHUDProgress dismiss];
}

- (void)dealloc {
    [THHUDProgress dismiss];
    @try {
        [self.webView removeObserver:self forKeyPath:@"title"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}

- (NSString *)fixImagesInHtmlString:(NSString *)string {
    return [NSString stringWithFormat:@"<html> \n"
            "<head> \n"
            "<style type=\"text/css\"> \n"
            "* {margin:0; padding:0;}\n"
            "img {width:100%%; height:auto; display:block;}\n"
            "</style> \n"
            "</head> \n"
            "<body>%@"
            "</body>"
            "</html>",string];
}

@end
