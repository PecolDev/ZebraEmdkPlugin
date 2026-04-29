package dev.pecol.zebra_emdk_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin

class ZebraEmdkPlugin : FlutterPlugin {
    private val emdkManagerHandler: EmdkManagerHandler = EmdkManagerHandler()

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        emdkManagerHandler.setupChannels(flutterPluginBinding.binaryMessenger)
        emdkManagerHandler.initializeHandler(flutterPluginBinding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        emdkManagerHandler.cleanup()
    }
}