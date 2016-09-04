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

#include "utils.h"

int getFnKeysMode()
{
	Boolean validValue;
	Boolean result;
	
	result = CFPreferencesGetAppBooleanValue(CFSTR("fnState"), CFSTR("com.apple.keyboard"), &validValue);
	
	if (result && validValue) {
		return kfnFunctionMode;
	}else if (!result && validValue){
		return kfnAppleMode;
	}
	
	return kfnUnknownMode;
	
}

void setFnKeysToFunctionMode()
{
	unsigned int result = lowLevelFnToggle(kfnFunctionMode);
	if (result == -1) return;
	
	CFPreferencesSetAppValue( CFSTR("fnState"), kCFBooleanTrue, CFSTR("com.apple.keyboard") );
	CFPreferencesAppSynchronize( CFSTR("com.apple.keyboard") );
	
	NSDictionary *dict = @{@"state": @YES};
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.apple.keyboard.fnstatedidchange" object:NULL userInfo:dict deliverImmediately:YES];
	
}

void setFnKeysToAppleMode()
{
	unsigned int result = lowLevelFnToggle(kfnAppleMode);
	if (result == -1) return;
	
	CFPreferencesSetAppValue( CFSTR("fnState"), kCFBooleanFalse, CFSTR("com.apple.keyboard") );
	CFPreferencesAppSynchronize( CFSTR("com.apple.keyboard") );
	
	NSDictionary *dict = @{@"state": @NO};
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.apple.keyboard.fnstatedidchange" object:NULL userInfo:dict deliverImmediately:YES];
	
}

int lowLevelFnToggle(int newMode)
{
	kern_return_t kernelReturnCode;
	mach_port_t machPort;
	io_service_t ioService;
	io_connect_t ioConnect;
	io_iterator_t ioIterator;
	CFDictionaryRef classToMatch;
	unsigned int result, settingsLocalCopy;
	
	kernelReturnCode = IOMasterPort(bootstrap_port, &machPort);
	if (kernelReturnCode != KERN_SUCCESS) return -1;
	
	classToMatch = IOServiceMatching(kIOHIDSystemClass);
	if (classToMatch == NULL) return -1;
	
	kernelReturnCode = IOServiceGetMatchingServices(machPort, classToMatch, &ioIterator);
	if (kernelReturnCode != KERN_SUCCESS) return -1;
	
	ioService = IOIteratorNext(ioIterator);
	IOObjectRelease(ioIterator);
	
	if (!ioService) return -1;
	
	kernelReturnCode = IOServiceOpen(ioService, mach_task_self(), kIOHIDParamConnectType, &ioConnect);
	if (kernelReturnCode != KERN_SUCCESS) return -1;
	
	kernelReturnCode = IOHIDGetParameter(ioConnect, CFSTR(kIOHIDFKeyModeKey), sizeof(result), &result, (IOByteCount *) &settingsLocalCopy);
	if (kernelReturnCode != KERN_SUCCESS) {
		IOServiceClose(ioConnect);
		return -1;
	}
	
	if (newMode == kfnAppleMode || newMode == kfnFunctionMode) {
		settingsLocalCopy = newMode;
		kernelReturnCode = IOHIDSetParameter(ioConnect, CFSTR(kIOHIDFKeyModeKey), &settingsLocalCopy, sizeof(settingsLocalCopy));
		if (kernelReturnCode != KERN_SUCCESS) {
			IOServiceClose(ioConnect);
			return -1;
		}
	}
	
	IOServiceClose(ioConnect);
	return result;
}

