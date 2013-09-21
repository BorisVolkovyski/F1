//
//  VBVAppDelegate.h
//  F1
//
//  Created by Boris Volkovyski on 20.02.13.
//  Copyright (c) 2013 Boris Volkovyski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VBVAppDelegate : NSObject <NSApplicationDelegate>{
  IBOutlet NSMenu *statusMenu;
  NSStatusItem *statusItem;
  NSImage *statusImage;
  NSImage *statusHighlightImage;
}

- (IBAction)switchFState:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
