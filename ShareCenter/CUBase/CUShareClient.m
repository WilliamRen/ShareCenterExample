//
//  CUShareClient.m
//  ShareCenterExample
//
//  Created by curer yg on 12-3-20.
//  Copyright (c) 2012年 zhubu. All rights reserved.
//

#import "CUShareClient.h"
#import "CUShareOAuthView.h"

@implementation CUShareClient

@synthesize delegate;
@synthesize viewClient;

- (void)dealloc
{
    self.viewClient = nil;
    
    [super dealloc];
}

- (void)CUOpenAuthViewInViewController:(UIViewController *)vc;
{
    self.viewClient = [[[CUShareOAuthView alloc] init] autorelease];
    self.viewClient.loginRequest = [self CULoginURLRequest];
    self.viewClient.webView.delegate = self;
    [self.viewClient.webView loadRequest:[self CULoginURLRequest]];
    
    [vc presentModalViewController:viewClient animated:YES];
}

- (NSURLRequest *)CULoginURLRequest
{
    return nil;
}

- (void)CUNotifyShareFailed:(CUShareClient *)client withError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(CUShareFailed:withError:)]) {
        [delegate CUShareFailed:client withError:error];
    }
    
    [self.viewClient performSelector:@selector(close:) withObject:nil afterDelay:.2f];
}

- (void)CUNotifyShareSucceed:(CUShareClient *)client
{
    if ([delegate respondsToSelector:@selector(CUShareSucceed:)]) {
        [delegate CUShareSucceed:client];
    }
    
    [self.viewClient performSelector:@selector(close:) withObject:nil afterDelay:.2f];
}

- (void)CUNotifyShareCancel:(CUShareClient *)client
{
    if ([delegate respondsToSelector:@selector(CUSHareCancel:)]) {
        [delegate CUSHareCancel:client];
    }
    
    [self.viewClient performSelector:@selector(close:) withObject:nil afterDelay:.20f];
}

- (void)CUNotifyAuthSucceed:(CUShareClient *)client
{
    if ([delegate respondsToSelector:@selector(CUAuthSucceed:)]) {
        [delegate CUAuthSucceed:client];
    }
    
    [self.viewClient performSelector:@selector(close:) withObject:nil afterDelay:.2f];
}

- (void)CUNotifyAuthFailed:(CUShareClient *)client withError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(CUShareFailed:withError:)]) {
        [delegate CUShareFailed:client withError:error];
    }
    
    [self.viewClient performSelector:@selector(close:) withObject:nil afterDelay:.2f];
}

@end
