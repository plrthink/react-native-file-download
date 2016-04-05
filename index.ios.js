'use strict'

var RNFileDownload = require('react-native').NativeModules.RNFileDownload
var promisify = require("es6-promisify")

var _download = promisify(RNFileDownload.download)

var _error = (err) => {
  throw err
}

var FileDownload = {
  download(source, target, headers = {}) {
    return _download(source, target, headers)
      .catch(_error)
  }
}

module.exports = FileDownload
