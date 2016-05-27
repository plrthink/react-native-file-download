'use strict'

var React = require('react')
var RNFileDownload = React.NativeModules.RNFileDownload
var NativeAppEventEmitter = React.NativeAppEventEmitter
var promisify = require("es6-promisify")

let progressEventName = 'RNFileDownloadProgress'
let progressEventTable = {}
var _download = promisify(RNFileDownload.download)

var _error = (err) => {
  throw err
}

var FileDownload = {
  download(source, target, fileName=null, headers={}) {
    return _download(source, target, fileName, headers)
      .catch(_error)
  },
  addListener(source, callback) {
    return NativeAppEventEmitter.addListener(progressEventName + source, callback)
  }
}

module.exports = FileDownload
