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

#ifndef utils_h
#define utils_h

#include <IOKit/IOKitLib.h>
#include <IOKit/IOReturn.h>
#include <ApplicationServices/ApplicationServices.h>
#include <IOKit/hidsystem/IOHIDLib.h>
#include <IOKit/hidsystem/IOHIDParameter.h>
#include <Foundation/Foundation.h>

#define kMyDriversKeyboardClassName     "AppleADBKeyboard"
#define kfnSwitchError                  200
#define kfnAppleMode            0
#define kfnFunctionMode         1
#define kfnUnknownMode          2

#ifndef kIOHIDFKeyModeKey
#define kIOHIDFKeyModeKey    "HIDFKeyMode"
#endif

/*!
 @brief Checks and returns current mode of top row of keys (F1-F12).
 
 @discussion  There may be function ans special mode of keys, so method returns<br/>
				<b>kfnAppleMode</b> for special mode (volume, iTunes controls, etc),<br/>
				<b>kfnFunctionMode</b> for regular F1-F12,<br/>
				and <b>kfnUnknownMode</b> if something gone wrong with mode check.
 
 @return int Current mode of top row of keys
 */
int getFnKeysMode();

/*!
 @brief Low level toggle mode of top row of keys (F1-F12).
 
 @discussion  There may be function ans special mode of keys, so method takes<br/>
 <b>kfnAppleMode</b> for special mode (volume, iTunes controls, etc),<br/>
 <b>kfnFunctionMode</b> for regular F1-F12.
 
 @param  newMode Code of mode to toggle to.
 
 @return int Current mode of top row of keys or -1 if failed.
 */
int lowLevelFnToggle(int newMode);

/*!
 @brief Set mode of top row of keys (F1-F12) to functions mode.
  */
void setFnKeysToFunctionMode();

/*!
 @brief Set mode of top row of keys (F1-F12) to special mode (volume, iTunes controls, etc).
 */
void setFnKeysToAppleMode();

#endif /* utils_h */
