# React Native File Download

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
const FileDownload = require('react-native').NativeModules.RNFileDownload
```


## API

**download(source: string, target: string): Promise**

> download file from source to target

Example

```js
FileDownload.download(`url`, `folderPath`)
.then(() => {
  console.log('downloaded!')
})
catch((error) => {
  console.log(error)
})
```
