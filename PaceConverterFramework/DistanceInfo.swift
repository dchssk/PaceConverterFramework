//
//  File.swift
//  PacesCalculator
//
//  Created by dchSsk on 2018/10/15.
//  Copyright © 2018年 dchssk. All rights reserved.
//  This software is released under the MIT License, see LICENSE
//

import Foundation

public class DistanceInfo : NSObject {
	public var tag: String = NSUUID().uuidString
	
	public var distance: Measurement<UnitLength>
	public var time: DateComponents?
	
	public var pace: DateComponents
	public var speed: Measurement<UnitSpeed>
	
	public var name: String
	
	public init(name: String, distance: Measurement<UnitLength>, speed: Measurement<UnitSpeed>){
		let converter = PaceConverter()
		
		self.name = name
		self.distance = distance
		self.speed = speed
		self.pace = converter.speedToPace(speed: speed)
	}
	
	public init(name: String, distance: Measurement<UnitLength>, pace: DateComponents){
		let converter = PaceConverter()
		
		self.name = name
		self.distance = distance
		self.pace = pace
		self.speed = converter.paceToSpeed(dateComponents: pace)
	}

	public init(name: String, distance: Measurement<UnitLength>, time: DateComponents?, pace: DateComponents, speed: Measurement<UnitSpeed>){
		self.name = name
		self.distance = distance
		self.time = time
		self.pace = pace
		self.speed = speed
	}
}
