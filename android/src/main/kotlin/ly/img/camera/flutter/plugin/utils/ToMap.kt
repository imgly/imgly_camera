package ly.img.camera.flutter.plugin.utils

import android.graphics.RectF
import ly.img.camera.core.Recording
import ly.img.camera.core.Video
import kotlin.time.DurationUnit

fun Recording.toMap() = mutableMapOf<String, Any?>(
    "videos" to videos.map { it.toMap() },
    "duration" to duration.toDouble(DurationUnit.MILLISECONDS),
)

fun Video.toMap() = mutableMapOf<String, Any?>(
    "uri" to uri.toString(),
    "rect" to rect.toMap(),
)

fun RectF.toMap() = mutableMapOf<String, Any?>(
    "x" to left,
    "y" to top,
    "width" to width(),
    "height" to height(),
)

fun ly.img.camera.core.CameraResult.Record.toMap() = mutableMapOf<String, Any?>(
    "recordings" to recordings.map { it.toMap() },
)

fun ly.img.camera.core.CameraResult.Reaction.toMap() = mutableMapOf<String, Any?>(
    "recordings" to this.reaction.map { it.toMap() },
    "video" to this.video.toMap(),
)

fun ly.img.camera.core.CameraResult.toMap() = when (this) {
    is ly.img.camera.core.CameraResult.Record -> mutableMapOf<String, Any?>("recording" to this.toMap())
    is ly.img.camera.core.CameraResult.Reaction -> mutableMapOf<String, Any?>("reaction" to this.toMap())
    else -> mutableMapOf<String, Any?>(
        "error" to "Unknown camera result type: ${this::class.java.simpleName}",
    )
}
