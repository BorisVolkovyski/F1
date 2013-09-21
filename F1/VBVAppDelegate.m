//
//  VBVAppDelegate.m
//  F1
//
//  Created by Boris Volkovyski on 20.02.13.
//  Copyright (c) 2013 Boris Volkovyski. All rights reserved.
//

#import "VBVAppDelegate.h"

@implementation VBVAppDelegate

- (void)dealloc {
  /* Use this to make an icon in menubar
  [statusImage release];
  [statusHighlightImage release];
  */
  [super dealloc];
}

- (void) awakeFromNib {
  statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
  /* Use this to make an icon in menubar
  NSBundle *bundle = [NSBundle mainBundle];
  statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Icon1" ofType:@"png"]];
  statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Icon2" ofType:@"png"]];
  [statusItem setImage:statusImage];
  */
  [statusItem setTitle:@"F1"];
	//[statusItem setAlternateImage:statusHighlightImage];
  [statusItem setMenu:statusMenu];
  [statusItem setToolTip:@"Switch keyboard F-keys behavior"];
  [statusItem setHighlightMode:YES];
  
}

- (IBAction)switchFState:(id)sender{
  [NSApp activateIgnoringOtherApps:YES];
  
  NSURL *scriptURL = [[NSBundle mainBundle] URLForResource:@"switch" withExtension:@"scpt"];
  
  NSAppleScript *script = [[NSAppleScript alloc] initWithContentsOfURL:scriptURL error:nil];
  
  [script executeAndReturnError:nil];
  
  [script release];
}

@end
