// Ensure to provide a Package so home_widget can find it for updates
package es.antonborri.home_widget_workshop

import HomeWidgetGlanceWidgetReceiver

class WorkshopWidget : HomeWidgetGlanceWidgetReceiver<WorkshopAppWidget>() {
  override val glanceAppWidget: WorkshopAppWidget
    get() = WorkshopAppWidget()
}