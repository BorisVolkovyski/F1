/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this source code; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#import "VBVAppDelegate.h"
#import "utils.h"

@implementation VBVAppDelegate


- (void) awakeFromNib {
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	
	/* Use this to make an icon in menubar
  NSBundle *bundle = [NSBundle mainBundle];
  statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Icon1" ofType:@"png"]];
  statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Icon2" ofType:@"png"]];
  [statusItem setImage:statusImage];
  [statusItem setAlternateImage:statusHighlightImage];
  */
	
	[statusItem setTitle: @"F1"];
	[statusItem setMenu: statusMenu];
	[statusItem setToolTip: @"Switch keyboard F-keys behavior"];
	[statusItem setHighlightMode:YES];
	
	int fnKeysState = getFnState();
	
	if (fnKeysState == kfnAppleMode){
		_hintMenuItem.title = @"F-keys operating as special keys";
		_controlMenuItem.title = @"Switch to function keys";
	}else if (fnKeysState == kfnFunctionMode){
		_hintMenuItem.title = @"F-keys operating as function keys";
		_controlMenuItem.title = @"Switch to special keys";
	}else if (fnKeysState == kfnUnknownMode){
		_hintMenuItem.title = @"Ups... Something went wrong";
		_controlMenuItem.title = @"Unknown mode";
	}
	
}

- (IBAction)switchFState:(id)sender{
	int fnKeysState = getFnState();
	
	if (fnKeysState == kfnAppleMode){
		setFnKeysToFunctionMode();
		_hintMenuItem.title = @"F-keys operating as function keys";
		_controlMenuItem.title = @"Switch to special keys";
	}else if (fnKeysState == kfnFunctionMode){
		setFnKeysToAppleMode();
		_hintMenuItem.title = @"F-keys operating as special keys";
		_controlMenuItem.title = @"Switch to function keys";
	}else if (fnKeysState == kfnUnknownMode){
		_hintMenuItem.title = @"Ups... Something went wrong";
		_controlMenuItem.title = @"Unknown mode";
	}

}

@end
