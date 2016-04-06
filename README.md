# React Native File Download [![react-native-file-download](http://img.shields.io/npm/dm/react-native-file-download.svg)](https://www.npmjs.org/package/react-native-file-download)

Native file download utility for react-native

Note: this project is under development and functionality will improve over time. Currently it provides only the bare minimum of functionality.

## Installation

```bash
npm install react-native-file-download --save
```

 Note that does not support Android.

## Getting started - iOS

1. In XCode, in the project navigator right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-file-download` and add `RNFileDownload.xcodeproj`
3. Add `libRNFileDownload.a` (from 'Products' under RNFileDownload.xcodeproj) to your project's `Build Phases` ➜ `Link Binary With Libraries` phase
4. Look for Header Search Paths and make sure it contains both `$(SRCROOT)/../react-native/React` and `$(SRCROOT)/../../React` - mark both as recursive
5. Run your project (`Cmd+R`)

## Usage

require it in your file

```js
const FileDownload = require('react-native-file-download')
```

you may also want to use something like [react-native-fs](https://github.com/johanneslumpe/react-native-fs) to access the file system (check its repo for more information)

```js
const RNFS = require('react-native-fs')
```

## API

**download(source: string, target: string): Promise**

> download file from source to target

Example

```js
let url = '/path/to/remote/file'
let folderPath = RNFS.DocumentDirectoryPath

FileDownload.download(url, folderPath)
.then((response) => {
  console.log('downloaded! file saved to: ' + response)
})
.catch((error) => {
  console.log(error)
})
```

**addListener(source: string, callback: function): EmitterSubscription**

> event listener for progress of download

Example

```js
let url = '/path/to/remote/file'
let folderPath = RNFS.DocumentDirectoryPath

FileDownload.addListener(url, (info) => {
  console.log('complete ' + (info.totalBytesWritten / info.totalBytesExpectedToWrite * 100) + '%');
});

FileDownload.download(url, folderPath)
.then((response) => {
  console.log('downloaded! file saved to: ' + response)
})
.catch((error) => {
  console.log(error)
})
```
