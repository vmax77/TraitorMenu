//
//  AppDelegate.m
//  TraitorMenu
//
//  Created by Vignesh Viswanath on 07/08/2015.
//  Copyright © 2015 VV. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;


@property (strong, nonatomic) NSStatusItem *statusToggle;  //Toggle Button
@property (assign, nonatomic) BOOL darkModeStatus; //Current Status of the Dark mode

@end

@implementation AppDelegate


- (void)itemClicked:(id)sender {
    
    
    NSEvent* event = [NSApp currentEvent];
    
    if ([event modifierFlags] & NSControlKeyMask){
        [[NSApplication sharedApplication]terminate:self];
        return;
    }
    
    _darkModeStatus =!_darkModeStatus;
    
    if(_darkModeStatus) //Check if Dark Mode is On
    {
        [self darkMode];
    }
    else //If Dark Mode is not On
    {
        [self lightMode];
    }
    
   
};


-(void)darkMode{
    CFPreferencesSetValue((CFStringRef)@"AppleInterfaceStyle", @"Dark", kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    dispatch_async(dispatch_get_main_queue(), ^{
        CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), (CFStringRef)@"AppleInterfaceThemeChangedNotification", NULL, NULL, YES);
    });

}

-(void)lightMode{
    CFPreferencesSetValue((CFStringRef)@"AppleInterfaceStyle", NULL, kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
    dispatch_async(dispatch_get_main_queue(), ^{
        CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), (CFStringRef)@"AppleInterfaceThemeChangedNotification", NULL, NULL, YES);
    });

}

    /* NSAlert* alert = [[NSAlert alloc]init];
    
    [alert setMessageText:@"Toggle Acknowledged!"];
    [alert addButtonWithTitle:@"Gotcha!"];
    [alert setInformativeText:@"Status Toggle was Clicked!"];
    
    
   NSAlert* alert = [NSAlert alertWithMessageText:@"Toggle Acknowledged!"
                                     defaultButton:@"Gotcha! "
                                   alternateButton:nil
                                       otherButton:nil
                         informativeTextWithFormat:@"Status Toggle was Clicked"];

    [alert runModal]; */



-(void)refreshDarkMode {
    
    NSString* value = (__bridge NSString*)(
                                           CFPreferencesCopyValue(
                                                                  (CFStringRef)@"AppleInterfaceStyle", kCFPreferencesAnyApplication, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost));
    
    
    if ([value isEqualToString:@"Dark"]){
        self.darkModeStatus = YES;
    }
    else
    {
        self.darkModeStatus=NO;
    }
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    self.statusToggle = [[NSStatusBar systemStatusBar]statusItemWithLength:NSVariableStatusItemLength];
    _statusToggle.image= [NSImage imageNamed:@"Simple Display"];
    [_statusToggle.image setTemplate:YES];
    
    [_statusToggle setAction: @selector(itemClicked:)];

    [self refreshDarkMode];
    
    
        
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
