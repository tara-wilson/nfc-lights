# NFC Lights

## Overview

This app uses NFC scanning to detect NFC frequencies in my apartment (near my desk and bed) to know where I am and turn on and off the lights accordingly. The lights are controlled by wifi enabled outlets by tuya smart. When the correct NFC tag is detected, a webhooks call is made to ifttt to control the lights.

ISSUES- NFC DOES NOT SCAN IN BACKGROUND ON IOS YET. So, tbh, opening the app and telling it to scan is honestly more work than just turning on and off the lights. But, someday iOS will allow background NFC scanning, and I will be ready!

## Getting Started

An iPhone 7 or iPhone 7 Plus running iOS 11 is required.  The first step is to enable "Near Field Communication Tag Reading" in the project's Capabilities pane to acquire the necessary entitlements.  Please visit ['Certificates, Identifiers, and Profiles'](https://developer.apple.com/account/ios/certificate/) in the Apple Developer portal to manually request a provisioning profile if the NFC capability is unavailable in your beta version of Xcode.
