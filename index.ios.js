'use strict'

var RNFileDownload = require('react-native').NativeModules.RNFileDownload
var Promise = require('bluebird')

var _download = Promise.promisify(RNFileDownload.download)

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
