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

#import <Foundation/Foundation.h>

/*!
 @class VBVNotifier
 
 @brief Simple notification sender class
 
 @discussion    This class was designed and implemented to help people send system notifications to user OS X desktop.
 
 @superclass SuperClass: NSObject
 */
@interface VBVNotifier : NSObject

/*!
 @brief Shows system notification banner.
 
 @discussion This method accepts a NSString values representing the title and text of notification.
 
 To use it, simply call @c[VBVNotifier showNotifiacationWithTitle: @@"Your notification title" andText: @@"Your notification text"];
 
 @param  notificationTitle The title to be displayed in notification.
 
 @param  notificationText The text to be displayed in notification.
 */
+ (void) showNotifiacationWithTitle: (NSString*) notificationTitle andText: (NSString*) notificationText;

@end
