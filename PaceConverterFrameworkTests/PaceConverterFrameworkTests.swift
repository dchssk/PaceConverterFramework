//
//  PaceConverterFrameworkTests.swift
//  PaceConverterFrameworkTests
//
//  Created by dchSsk on 2018/07/06.
//  Copyright © 2018年 Daichi Sasaki. All rights reserved.
//

import XCTest
import PaceConverterFramework

class PaceConverterFrameworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	func testSpeedToPace() {
		let converter = PaceConverter()
		
		var pace = converter.speedToPace(speed: Measurement(value: 10, unit: UnitSpeed.kilometersPerHour))
		XCTAssertEqual(pace.minute, 6)
		XCTAssertEqual(pace.second, 0)
		
		pace = converter.speedToPace(speed: Measurement(value: 11.5, unit: UnitSpeed.kilometersPerHour))
		XCTAssertEqual(pace.minute, 5)
		XCTAssertEqual(pace.second, 13)
		
		pace = converter.speedToPace(speed: Measurement(value: 6, unit: UnitSpeed.kilometersPerHour))
		XCTAssertEqual(pace.minute, 10)
		XCTAssertEqual(pace.second, 0)
		
		pace = converter.speedToPace(speed: Measurement(value: 1, unit: UnitSpeed.kilometersPerHour))
		XCTAssertEqual(pace.hour, 1)
		XCTAssertEqual(pace.minute, 0)
		XCTAssertEqual(pace.second, 0)
	}
	
	func testPaceToSpeed() {
		let converter = PaceConverter()
		
		var timeComps = DateComponents()

		timeComps.hour   = 0
		timeComps.minute = 6
		timeComps.second = 0
		var speed = converter.paceToSpeed(dateComponents: timeComps)
		XCTAssertEqual(floor(speed.value*10)/10, 10.0)
		
		timeComps.hour   = 0
		timeComps.minute = 5
		timeComps.second = 13
		speed = converter.paceToSpeed(dateComponents: timeComps)
		XCTAssertEqual(floor(speed.value*10)/10, 11.5)
		
		timeComps.hour   = 0
		timeComps.minute = 10
		timeComps.second = 0
		speed = converter.paceToSpeed(dateComponents: timeComps)
		XCTAssertEqual(floor(speed.value*10)/10, 6)
		
		timeComps.hour   = 1
		timeComps.minute = 0
		timeComps.second = 0
		speed = converter.paceToSpeed(dateComponents: timeComps)
		XCTAssertEqual(floor(speed.value*10)/10, 1.0)
	}
	
	func testCalcDistanceTime(){
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
		
		XCTAssertEqual(timeList[distanceList[1]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[1]]?.minute, 2)
		XCTAssertEqual(timeList[distanceList[1]]?.second, 24)
		
		XCTAssertEqual(timeList[distanceList[2]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[2]]?.minute, 4)
		XCTAssertEqual(timeList[distanceList[2]]?.second, 48)
		
		XCTAssertEqual(timeList[distanceList[3]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[3]]?.minute, 6)
		XCTAssertEqual(timeList[distanceList[3]]?.second, 0)
		
		XCTAssertEqual(timeList[distanceList[4]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[4]]?.minute, 30)
		XCTAssertEqual(timeList[distanceList[4]]?.second, 0)
		
		XCTAssertEqual(timeList[distanceList[5]]?.hour, 1)
		XCTAssertEqual(timeList[distanceList[5]]?.minute, 0)
		XCTAssertEqual(timeList[distanceList[5]]?.second, 0)
		
		XCTAssertEqual(timeList[distanceList[6]]?.hour, 2)
		XCTAssertEqual(timeList[distanceList[6]]?.minute, 6)
		XCTAssertEqual(timeList[distanceList[6]]?.second, 35)
		
		XCTAssertEqual(timeList[distanceList[7]]?.hour, 4)
		XCTAssertEqual(timeList[distanceList[7]]?.minute, 13)
		XCTAssertEqual(timeList[distanceList[7]]?.second, 10)
		
		speed = Measurement.init(value: 13.5, unit: UnitSpeed.kilometersPerHour)
		timeList = converter.calcDistanceTime(speed: speed, distanceArray: distanceList)
		XCTAssertEqual(timeList[distanceList[0]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[0]]?.minute, 0)
		XCTAssertEqual(timeList[distanceList[0]]?.second, 53)
		
		XCTAssertEqual(timeList[distanceList[1]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[1]]?.minute, 1)
		XCTAssertEqual(timeList[distanceList[1]]?.second, 46)
		
		XCTAssertEqual(timeList[distanceList[2]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[2]]?.minute, 3)
		XCTAssertEqual(timeList[distanceList[2]]?.second, 33)
		
		XCTAssertEqual(timeList[distanceList[3]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[3]]?.minute, 4)
		XCTAssertEqual(timeList[distanceList[3]]?.second, 26)
		
		XCTAssertEqual(timeList[distanceList[4]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[4]]?.minute, 22)
		XCTAssertEqual(timeList[distanceList[4]]?.second, 13)
		
		XCTAssertEqual(timeList[distanceList[5]]?.hour, 0)
		XCTAssertEqual(timeList[distanceList[5]]?.minute, 44)
		XCTAssertEqual(timeList[distanceList[5]]?.second, 26)
		
		XCTAssertEqual(timeList[distanceList[6]]?.hour, 1)
		XCTAssertEqual(timeList[distanceList[6]]?.minute, 33)
		XCTAssertEqual(timeList[distanceList[6]]?.second, 46)
		
		XCTAssertEqual(timeList[distanceList[7]]?.hour, 3)
		XCTAssertEqual(timeList[distanceList[7]]?.minute, 7)
		XCTAssertEqual(timeList[distanceList[7]]?.second, 32)
	}
	
	func testEquals(){
		let converter = PaceConverter()
		
		var old:Measurement<UnitSpeed>
		var new:Measurement<UnitSpeed>
		var pace:DateComponents
		
		old = Measurement(value: 13.8, unit: UnitSpeed.kilometersPerHour)
		pace = converter.speedToPace(speed: old)
		new = converter.paceToSpeed(dateComponents: pace)
		XCTAssertEqual(String(format:"%.1f", old.value), String(format:"%.1f", new.value))
		
		old = Measurement(value: 13.9, unit: UnitSpeed.kilometersPerHour)
		pace = converter.speedToPace(speed: old)
		new = converter.paceToSpeed(dateComponents: pace)
		XCTAssertEqual(String(format:"%.1f", old.value), String(format:"%.1f", new.value))
		
		old = Measurement(value: 14.0, unit: UnitSpeed.kilometersPerHour)
		pace = converter.speedToPace(speed: old)
		new = converter.paceToSpeed(dateComponents: pace)
		XCTAssertEqual(String(format:"%.1f", old.value), String(format:"%.1f", new.value))
		
		old = Measurement(value: 14.1, unit: UnitSpeed.kilometersPerHour)
		pace = converter.speedToPace(speed: old)
		new = converter.paceToSpeed(dateComponents: pace)
		XCTAssertEqual(String(format:"%.1f", old.value), String(format:"%.1f", new.value))
	}
	
	func testDistanceStruct(){
		let converter = PaceConverter()
		
		let array = [
			DistanceInfo(name:"hoge1",
						 distance: Measurement.init(value: 1000, unit: UnitLength.meters),
						   speed: Measurement.init(value: 10, unit: UnitSpeed.kilometersPerHour)),
			DistanceInfo(name:"hoge2",
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
	}
}
