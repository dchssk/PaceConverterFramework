//
//  PaceConverter.swift
//  PaceConverterFramework
//
//  Created by dchSsk on 2017/02/07.
//  Copyright © 2017年 Daichi Sasaki. All rights reserved.
//  This software is released under the MIT License, see LICENSE
//

import UIKit

public class PaceConverter: NSObject {
	
    /// 時速(km/h) -> ペース(minute/km) 変換
    public func speedToPace(speed: Measurement<UnitSpeed>) -> DateComponents{
        let kmSpeed = speed.converted(to: UnitSpeed.kilometersPerHour)
		
		var timeInterval : TimeInterval = 0
		if kmSpeed.value != 0 {
			timeInterval = (3600 / kmSpeed.value)
		}

		return self.secondsToDateComponents(seconds: timeInterval)
	}
    
    /// ペース(minute/km) -> 時速(km/h) 変換
    public func paceToSpeed(dateComponents: DateComponents) -> Measurement<UnitSpeed>{
		var second: Double = 0.0
		if let date = dateComponents.date {
			second = date.timeIntervalSince1970
		}
		else{
			let hour: Double = Double(dateComponents.hour!)
			let minute: Double = Double(dateComponents.minute!)
			second = Double(dateComponents.second!) + minute * 60 + hour * 3600
		}

        let v = (3600 / second)
        return Measurement.init(value: v, unit: UnitSpeed.kilometersPerHour)
    }
	
	/// 時速(km/h) から、希望距離別の到達時間を返す
	public func calcDistanceTime(speed: Measurement<UnitSpeed>, distanceArray: [Measurement<UnitLength>]) -> [Measurement<UnitLength>:DateComponents]{
		var r:[Measurement<UnitLength>:DateComponents] = [:]
		let kmSpeed = speed.converted(to: UnitSpeed.kilometersPerHour)
		
		for distance in distanceArray {
			let meter = distance.converted(to: UnitLength.meters)
			let second = meter.value / kmSpeed.value / 1000 * 60 * 60
			
			r[distance] = self.secondsToDateComponents(seconds: second)
		}
		
		return r
	}
	
	/// 時速(km/h) から、希望距離別の到達時間を返す
	public func calcDistanceStruct(_ distanceStructArray : [DistanceInfo]) -> [Measurement<UnitLength>:DistanceInfo]{
		var r:[Measurement<UnitLength>:DistanceInfo] = [:]
		
		var totalSecond = 0.0
		var lastMeter = Measurement.init(value: 0, unit: UnitLength.meters)
		for distanceStruct in distanceStructArray {
			let kmSpeed = distanceStruct.speed.converted(to: UnitSpeed.kilometersPerHour)
			let calcMeter = distanceStruct.distance.converted(to: UnitLength.meters)
			let meter = calcMeter - lastMeter
			let second = meter.value / kmSpeed.value / 1000 * 60 * 60
			totalSecond += second
			
			r[distanceStruct.distance] = DistanceInfo(name:distanceStruct.name,
										 distance:distanceStruct.distance,
										 time:self.secondsToDateComponents(seconds: totalSecond),
										 pace:distanceStruct.pace,
										 speed:distanceStruct.speed)
			lastMeter = calcMeter
		}
		
		return r
	}

	private func secondsToDateComponents(seconds: TimeInterval) -> DateComponents {
		let date : Date = Date(timeIntervalSince1970:seconds)
		return Calendar.current.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: date)
	}
}
