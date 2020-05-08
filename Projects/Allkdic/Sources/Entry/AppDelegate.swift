// The MIT License (MIT)
//
// Copyright (c) 2013 Suyeol Jeon (http://xoul.kr)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Cocoa

import SimpleCocoaAnalytics
import SnapKit

final class AppDelegate: NSObject, NSApplicationDelegate {
  private let dependency: AppDependency

  init(dependency: AppDependency) {
    self.dependency = dependency
  }

  func applicationDidFinishLaunching(_ notification: Notification) {
    self.dependency.analyticsHelper.beginPeriodicReporting(
      withAccount: "UA-42976442-2",
      name:"올ㅋ사전",
      version: BundleInfo.version
    )

    PopoverController.sharedInstance()
    self.registerHotKey()
  }

  private func registerHotKey() {
    let savedKeyBinding = self.dependency.preferenceService.value(forKey: .hotKey)
    let keyBinding = savedKeyBinding ?? KeyBinding.default
    self.dependency.hotKeyService.register(keyBinding: keyBinding)
  }

  func applicationWillTerminate(_ notification: Notification) {
    self.dependency.analyticsHelper.handleApplicationWillClose()
  }
}
