//
//  MacApp.m
//  AppBundle
//
//  Created by Yong Yang on 5/26/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

#import "MacApp.h"

@import AppKit;

@implementation MacApp

+ (void) disableMaximizeButton
{
    NSArray *windows = NSApplication.sharedApplication.windows;
    
    NSWindowCollectionBehavior behavior = NSWindowCollectionBehaviorFullScreenAuxiliary | NSWindowCollectionBehaviorFullScreenNone;
    
    for (NSWindow *window in windows) {
        [window setCollectionBehavior:behavior];
        
        NSButton *button = [window standardWindowButton:NSWindowZoomButton];
        [button setEnabled:NO];
    }
}

@end
