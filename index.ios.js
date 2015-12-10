'use strict'

var RNFileDownload = require('react-native').NativeModules.RNFileDownload
var promisify = require("es6-promisify")

var _download = promisify(RNFileDownload.download)

var _error = (err) => {
  throw error
}

var FileDownload = {
  download(source, target) {
    return _download(source, target)
      .catch(_error)
  }
}

module.exports = FileDownload
