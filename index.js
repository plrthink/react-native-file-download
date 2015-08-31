'use strict'

var RNFileDownload = require('NativeModules').RNFileDownload

var FileDownload = {
  download: function(source, target, callback) {
    RNFileDownload.download(source, target, callback)
  }
}

module.exports = FileDownload
