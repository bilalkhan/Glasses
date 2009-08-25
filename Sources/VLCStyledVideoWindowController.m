/*****************************************************************************
 * Copyright (C) 2009 the VideoLAN team
 *
 * Authors: Pierre d'Herbemont
 *
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
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/

#import <VLCKit/VLCKit.h>

#import "VLCStyledVideoWindowController.h"
#import "VLCStyledVideoWindowView.h"
#import "VLCMediaDocument.h"

@implementation VLCStyledVideoWindowController
@synthesize videoView=_videoView;
- (VLCMediaDocument *)mediaDocument
{
    return (VLCMediaDocument *)[self document];
}

- (VLCMediaPlayer *)mediaPlayer
{
    return [self mediaDocument].mediaListPlayer.mediaPlayer;
}

- (NSString *)windowNibName
{
	return @"StyledVideoWindow";
}

- (void)windowDidLoad
{
    [super windowDidLoad];
	NSWindow * window = [self window];
    [window setDelegate:self];
    [_styledWindowView bind:@"ellapsedTime" toObject:self withKeyPath:@"document.mediaListPlayer.mediaPlayer.time.stringValue" options:nil];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:0], NSNullPlaceholderBindingOption, nil];
    [_styledWindowView bind:@"viewedPosition" toObject:self withKeyPath:@"document.mediaListPlayer.mediaPlayer.position" options:options];
    options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], NSNullPlaceholderBindingOption, nil];
    [_styledWindowView bind:@"viewedPlaying" toObject:self withKeyPath:@"document.mediaListPlayer.mediaPlayer.playing" options:options];
}

#pragma mark -
#pragma mark Window Delegate

- (void)windowDidBecomeKey:(NSNotification *)notification
{
    [_styledWindowView setKeyWindow:YES];
}
- (void)windowDidResignKey:(NSNotification *)notification
{
    [_styledWindowView setKeyWindow:NO];
}
- (void)windowDidBecomeMain:(NSNotification *)notification
{
    [_styledWindowView setMainWindow:YES];
}
- (void)windowDidResignMain:(NSNotification *)notification
{
    [_styledWindowView setMainWindow:YES];
}

@end