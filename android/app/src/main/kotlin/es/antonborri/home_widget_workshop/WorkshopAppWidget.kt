package es.antonborri.home_widget_workshop

import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import android.content.Context
import android.graphics.BitmapFactory
import android.net.Uri
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.action.ActionParameters
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.action.ActionCallback
import androidx.glance.appwidget.action.actionRunCallback
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.padding
import androidx.glance.state.GlanceStateDefinition
import androidx.glance.text.Text
import es.antonborri.home_widget.HomeWidgetBackgroundIntent

class WorkshopAppWidget : GlanceAppWidget() {

  override val stateDefinition: GlanceStateDefinition<*>
    get() = HomeWidgetGlanceStateDefinition()

  override suspend fun provideGlance(context: Context, id: GlanceId) {
    provideContent {
      GlanceContent(context, currentState())
    }
  }

  @Composable
  private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState) {
    val prefs = currentState.preferences
    val counter = prefs.getInt("counter", 0)
    val imagePath = prefs.getString("dash", null)
    Box(modifier = GlanceModifier.background(Color.White).padding(16.dp)) {
      Column(modifier = GlanceModifier.fillMaxSize(), verticalAlignment = Alignment.Vertical.CenterVertically, horizontalAlignment = Alignment.Horizontal.End) {
        Box(
            modifier = GlanceModifier.fillMaxWidth(),
            contentAlignment = Alignment.Center) {
          Text(counter.toString())
        }
        imagePath?.let {
          val bitmap = BitmapFactory.decodeFile(it)
          Box(
              modifier = GlanceModifier.clickable(
                  onClick = actionRunCallback<InteractiveAction>()),
          ) {
            Image(ImageProvider(bitmap), null)
          }
        }
      }
    }
  }
}

class InteractiveAction : ActionCallback {
  override suspend fun onAction(context: Context,
                                glanceId: GlanceId,
                                parameters: ActionParameters) {
    val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(
        context,
        Uri.parse("homeWidgetWorkshop://increment"))
    backgroundIntent.send()
  }
}