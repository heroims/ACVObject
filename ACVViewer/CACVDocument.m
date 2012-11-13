//
//	CDocument.m
//	ACVObject
//
//	Created by Jonathan Wight on 3/20/12.
//	Copyright 2012 Jonathan Wight. All rights reserved.
//
//	Redistribution and use in source and binary forms, with or without modification, are
//	permitted provided that the following conditions are met:
//
//	   1. Redistributions of source code must retain the above copyright notice, this list of
//	      conditions and the following disclaimer.
//
//	   2. Redistributions in binary form must reproduce the above copyright notice, this list
//	      of conditions and the following disclaimer in the documentation and/or other materials
//	      provided with the distribution.
//
//	THIS SOFTWARE IS PROVIDED BY JONATHAN WIGHT ``AS IS'' AND ANY EXPRESS OR IMPLIED
//	WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//	FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL JONATHAN WIGHT OR
//	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//	ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//	NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//	ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//	The views and conclusions contained in the software and documentation are those of the
//	authors and should not be interpreted as representing official policies, either expressed
//	or implied, of Jonathan Wight.

#import "CACVDocument.h"

#import "CACVObject.h"
#import "CACVCurvesView.h"
#import "NSImage+CGImage.h"
#import "CColorCurve.h"

@interface CACVDocument ()
@property (readwrite, nonatomic, assign) IBOutlet CACVCurvesView *curvesView;
@property (readwrite, nonatomic, assign) IBOutlet NSImageView *RGBLUTImageView;
@property (readwrite, nonatomic, assign) IBOutlet NSImageView *redLUTImageView;
@property (readwrite, nonatomic, assign) IBOutlet NSImageView *greenLUTImageView;
@property (readwrite, nonatomic, assign) IBOutlet NSImageView *blueLUTImageView;
@end

@implementation CACVDocument

- (NSString *)windowNibName
	{
	return @"CACVDocument";
	}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
	{
	[super windowControllerDidLoadNib:aController];
	
	self.curvesView.ACVObject = self.ACVObject;
	
	self.RGBLUTImageView.image = [NSImage imageWithCGImage:self.ACVObject.RGBCurve.CGImage];
	self.redLUTImageView.image = [NSImage imageWithCGImage:self.ACVObject.redCurve.CGImage];
	self.greenLUTImageView.image = [NSImage imageWithCGImage:self.ACVObject.greenCurve.CGImage];
	self.blueLUTImageView.image = [NSImage imageWithCGImage:self.ACVObject.blueCurve.CGImage];
	}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError;
	{
	self.ACVObject = [[CACVObject alloc] initWithURL:url];
	return(YES);
	}

- (IBAction)export:(id)sender
	{
	NSSavePanel *thePanel = [NSSavePanel savePanel];
	
	[thePanel beginSheetModalForWindow:[[self.windowControllers lastObject] window] completionHandler:^(NSInteger result) {
		if (result == NSOKButton)
			{
			[NSKeyedArchiver archiveRootObject:self.ACVObject toFile:thePanel.URL.path];
			}
		}];
	}

@end
