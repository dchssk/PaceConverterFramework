PaceConverterFramework
====
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/dchssk/PaceConverterFramework)

PaceConverterFramework is a simple framework for converting pace and speed.

## Install
### Carthage
- Add it to your Cartfile:
```
github "dchssk/PaceConverterFramework"
```
- Run `carthage update --platform iOS`
- Add 'PaceConverterFramework.framework' to 'Linked Frameworks and Library' on your project.
- Add `/usr/local/bin/carthage copy-frameworks` to 'New Run Script Phase'.
- Add `$(SRCROOT)/Carthage/Build/iOS/PaceConverterFramework.framework` to 'Input Files'.

### import
On your .swift file, import the module:
```swift
import PaceConverterFramework
```

## Key features

### Speed to pace
```swift
let converter = PaceConverter()

// 10km/h -> 06:00
var pace = converter.speedToPace(speed: Measurement(value: 10, unit: UnitSpeed.kilometersPerHour))
XCTAssertEqual(pace.minute, 6)
XCTAssertEqual(pace.second, 0)
```

###  Pace to speed
```swift
let converter = PaceConverter()

// 06:00 -> 10km/h
var timeComps = DateComponents()
timeComps.hour   = 0
timeComps.minute = 6
timeComps.second = 0
var speed = converter.paceToSpeed(dateComponents: timeComps)
XCTAssertEqual(floor(speed.value*10)/10, 10.0)
```

###  Calculate arrival time at constant pace
```swift
let converter = PaceConverter()

let distanceList = [
	Measurement.init(value: 200, unit: UnitLength.meters),
	Measurement.init(value: 400, unit: UnitLength.meters),
	Measurement.init(value: 800, unit: UnitLength.meters),
	Measurement.init(value: 1, unit: UnitLength.kilometers),
	Measurement.init(value: 5, unit: UnitLength.kilometers),
	Measurement.init(value: 10, unit: UnitLength.kilometers),
	Measurement.init(value: 42.195/2, unit: UnitLength.kilometers),
	Measurement.init(value: 42.195, unit: UnitLength.kilometers)
]

var speed = Measurement.init(value: 10, unit: UnitSpeed.kilometersPerHour)
var timeList = converter.calcDistanceTime(speed: speed, distanceArray: distanceList)
XCTAssertEqual(timeList[distanceList[0]]?.hour, 0)
XCTAssertEqual(timeList[distanceList[0]]?.minute, 1)
XCTAssertEqual(timeList[distanceList[0]]?.second, 12)
・・・
```

###  Calculate arrival times of different speeds in each section
```swift
let converter = PaceConverter()

let array = [
	DistanceInfo(name:"10.0 km/h",
		distance: Measurement.init(value: 1000, unit: UnitLength.meters),
		speed: Measurement.init(value: 10, unit: UnitSpeed.kilometersPerHour)),
	DistanceInfo(name:"10.9 km/h",
		distance: Measurement.init(value: 2000, unit: UnitLength.meters),
		speed: Measurement.init(value: 10.9, unit: UnitSpeed.kilometersPerHour))
]

var outputArray = converter.calcDistanceStruct(array)
var output = outputArray[array[0].distance]!
XCTAssertEqual(output.time?.hour, 0)
XCTAssertEqual(output.time?.minute, 6)
XCTAssertEqual(output.time?.second, 0)

output = outputArray[array[1].distance]!
XCTAssertEqual(output.time?.hour, 0)
XCTAssertEqual(output.time?.minute, 11)
XCTAssertEqual(output.time?.second, 30)
```

## Requirements
* Xcode 10.0
* iOS 10+
* Swift 4.2

## Licence

[MIT Licence](https://github.com/dchssk/PaceConverterFramework/blob/master/LICENSE)

## Author

[dchssk](https://github.com/dchssk)
