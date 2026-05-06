package ly.img.camera.flutter.plugin.model

/**
 * A class containing all necessary information to configure the camera.
 *
 * @property license The license key. Pass `null` to run the SDK in evaluation mode with a watermark.
 * @property userId The id of the current user.
 */
data class CameraSettings(
    val license: String? = null,
    val userId: String?,
) {
    companion object {
        fun createFromMap(map: Map<String, Any>?) = map?.let {
            CameraSettings(
                license = map["license"] as? String,
                userId = map["userId"] as? String,
            )
        }
    }
}
