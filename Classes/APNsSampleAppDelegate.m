//
//  APNsSampleAppDelegate.m
//  APNsSample
//
//  Created by 권오상 on 11. 1. 18..
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "APNsSampleAppDelegate.h"

@implementation APNsSampleAppDelegate

@synthesize window;

#pragma mark -
#pragma mark Apple Push Notifications

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
	NSLog(@"Error in registration. Error: %@", error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken { 
	NSLog(@"2. didRegisterForRemoteNotificationsWithDeviceToken");

	NSMutableString *deviceId = [NSMutableString string]; 
	const unsigned char* ptr = (const unsigned char*) [deviceToken bytes]; 
	
	for(int i = 0 ; i < 32 ; i++) 
	{ 
		[deviceId appendFormat:@"%02x", ptr[i]]; 
	} 
	
	NSLog(@"APNS Device Token: %@", deviceId); 
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo { 
	NSLog(@"didReceiveRemoteNotification");
	
	NSString *string = [NSString stringWithFormat:@"%@", userInfo]; 
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil 
													message:string delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil]; 
	[alert show]; 
	[alert release]; 
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 
	NSLog(@"1. didFinishLaunchingWithOptions");
	
	NSDictionary *userInfo = [launchOptions objectForKey:
							  UIApplicationLaunchOptionsRemoteNotificationKey]; 
	
	if(userInfo != nil) 
	{ 
		[self application:application didFinishLaunchingWithOptions:userInfo]; 
	} 
	
	// APNS에 디바이스를 등록한다. 
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes: 
	 UIRemoteNotificationTypeAlert| 
	 UIRemoteNotificationTypeBadge| 
	 UIRemoteNotificationTypeSound]; 
	
	return YES; 
} 

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{ 
	NSLog(@"applicationDidFinishLaunching");

	// didFinishLaunchingWithOptions를 구현할 경우 사용되지 않는다. 
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
} 


#pragma mark -
#pragma mark Memory management



- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
