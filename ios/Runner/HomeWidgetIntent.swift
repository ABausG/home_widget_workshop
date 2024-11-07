//
//  HomeWidgetIntent.swift
//  Runner
//
//  Created by Anton Borries on 07.11.24.
//

import AppIntents
import Flutter
import Foundation
import home_widget

@available(iOS 17, *)
public struct BackgroundIntent: AppIntent {
   static public var title: LocalizedStringResource = "HomeWidget Background Intent"

   @Parameter(title: "Uri")
   var url: URL?

   @Parameter(title: "AppGroup")
   var appGroup: String?

   public init() {}

   public init(url: URL?, appGroup: String?) {
      self.url = url
      self.appGroup = appGroup
   }

   public func perform() async throws -> some IntentResult {
      await HomeWidgetBackgroundWorker.run(url: url, appGroup: appGroup!)

      return .result()
   }
}
